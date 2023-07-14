import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futhinos_v2/core/exceptions/respository_exceptions.dart';
import 'package:futhinos_v2/models/hinos_model.dart';
import 'package:futhinos_v2/models/notas_model.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/services/globals.dart';
import 'get_times_repository.dart';

class GetTimesRepositoryImpl implements GetTimesRepository {
  @override
  Future<List<TimesModel>> getTimes() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshotTimes =
          await FirebaseFirestore.instance
              .collection(mainCollection)
              .orderBy("nomeTime", descending: false)
              .get();

      List<TimesModel> listaTimes = snapshotTimes.docs
          .map<TimesModel>(
              (listaHinos) => TimesModel.fromDocumentSnapshot(listaHinos))
          .toList();
      return listaTimes;
    } on FirebaseException catch (e, s) {
      log('erro ao buscar hinos', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message: 'Erro ao carregar dados. Tente novamente mais tarde.');
    }
  }

  @override
  List<TimesModel> runFilter(List<TimesModel> allListTimes, String keyword) {
    List<TimesModel> results = [];
    if (keyword.isEmpty) {
      results = allListTimes;
    } else {
      results = allListTimes
          .where((time) =>
              time.nomeTime!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return results;
  }

  @override
  List<String> geListUF(List<TimesModel> listaTimes, String filterType) {
    List<String>? choiceTimes = [];
    late List<String?> result;
    if (listaTimes.isNotEmpty) {
      result = listaTimes
          .map((e) {
            if (e.tipo == filterType) {
              return e.uf;
            }
          })
          .toSet()
          .toList();
    }
    result = result.whereNotNull().toList();
    result.sort();
    if (result.isNotEmpty) {
      choiceTimes = result.cast<String>();
    }
    return choiceTimes;
  }

  @override
  Future<void> createBD(List<TimesModel> times) async {
    for (var time in times) {
      var listHinos = time.hinos;
      for (var hino in listHinos!) {
        final addDocHino = FirebaseFirestore.instance
            .collection('hinos_v2')
            .doc(time.uidTime)
            .collection('hinos')
            .doc();
        HinosModel dadosHino = HinosModel(
            ano: hino['ano'],
            autor: hino['autor'],
            nome: hino['nome'],
            url: hino['url']);
        await FirebaseFirestore.instance
            .collection('hinos_v2')
            .doc(time.uidTime)
            .collection('hinos')
            .doc(addDocHino.id)
            .set(dadosHino.toMap());
      }
    }
  }

  @override
  Future<void> deleteHinos(List<TimesModel> times) async {
    for (var time in times) {
      final collectionRef = FirebaseFirestore.instance
          .collection('hinos_v2')
          .doc(time.uidTime)
          .collection('hinos');
      final futureQuery = collectionRef.get();
      await futureQuery.then((value) => value.docs.forEach((element) {
            element.reference.delete();
          }));
    }
  }

  @override
  Future<void> createOrderByHinos(List<TimesModel> listaTimes) async {
    for (var time in listaTimes) {
      await FirebaseFirestore.instance
          .collection('hinos_v2')
          .doc(time.uidTime)
          .collection('hinos')
          .get()
          .then((listaHinos) async {
        if (listaHinos.docs.isNotEmpty) {
          List<HinosModel> hinos = listaHinos.docs
              .map<HinosModel>((hino) => HinosModel.fromDocumentSnapshot(hino))
              .toList();
          int index = 1;
          for (var hino in hinos) {
            if (hino.nome == "Versão Oficial") {
              await FirebaseFirestore.instance
                  .collection('hinos_v2')
                  .doc(time.uidTime)
                  .collection('hinos')
                  .doc(hino.uidHino)
                  .set({'ordem': 0}, SetOptions(merge: true));
              index++;
            } else {
              await FirebaseFirestore.instance
                  .collection('hinos_v2')
                  .doc(time.uidTime)
                  .collection('hinos')
                  .doc(hino.uidHino)
                  .set({'ordem': index}, SetOptions(merge: true));
              index++;
            }
          }
        }
      });
    }
  }

  @override
  Future<void> createQtdaHinos(List<TimesModel> listaTimes) async {
    for (int i = 0; i < listaTimes.length; i++) {
      var time = listaTimes[i];
      await FirebaseFirestore.instance
          .collection(mainCollection)
          .doc(time.uidTime)
          .collection('hinos')
          .get()
          .then((listaHinos) async {
        if (listaHinos.docs.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection(mainCollection)
              .doc(time.uidTime)
              .set({"qtdaHinos": listaHinos.docs.length.toString()},
                  SetOptions(merge: true));
        }
      });
    }
  }

  @override
  Future<void> createNotaField(List<TimesModel> listaTimes) async {
    for (int i = 0; i < listaTimes.length; i++) {
      var time = listaTimes[i];
      print(time.nomeTime);
      await FirebaseFirestore.instance
          .collection(mainCollection)
          .doc(time.uidTime)
          .collection('hinos')
          .get()
          .then((listaHinos) async {
        if (listaHinos.docs.isNotEmpty) {
          List<HinosModel> hinos = listaHinos.docs
              .map<HinosModel>((hino) => HinosModel.fromDocumentSnapshot(hino))
              .toList();
          //int index = 1;
          for (var hino in hinos) {
            print(hino.nome);
            List<NotasModel> listaNotas =
                await getRate(time.uidTime!, hino.uidHino!);
            double notaMedia = calcRate(listaNotas);
            print(
                '${hino.nome}: notaMedia = $notaMedia (${listaNotas.length})');
            await FirebaseFirestore.instance
                .collection(mainCollection)
                .doc(time.uidTime)
                .collection('hinos')
                .doc(hino.uidHino)
                .set({"notaMedia": notaMedia}, SetOptions(merge: true));
            await FirebaseFirestore.instance
                .collection('ranking')
                .doc(hino.uidHino)
                .set({
              'nome': hino.nome,
              'autor': hino.autor,
              'ano': hino.ano,
              'notaMedia': notaMedia,
              'ordem': hino.ordem,
              'url': hino.url,
              'uidTime': time.uidTime,
              'nomeTime': time.nomeTime,
              'escudoURL': time.escudoURL,
              'urlLetra': time.urlLetra,
              'cidade': time.cidade,
              'uf': time.uf,
              'qtdaHinos': time.qtdaHinos,
              'tipo': time.tipo,
              'qtdaNotas': listaNotas.length
            }, SetOptions(merge: true));
          }
        }
      });
    }
  }

  double calcRate(List<NotasModel> listaNotas) {
    double somaNotas = 0.0;
    int totalNotas = listaNotas.length;
    for (var nota in listaNotas) {
      if (nota.nota != null) {
        somaNotas = nota.nota! + somaNotas;
      }
    }

    return somaNotas / totalNotas;
  }

  Future<List<NotasModel>> getRate(String uidTime, String uidHino) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection(mainCollection)
          .doc(uidTime)
          .collection('hinos')
          .doc(uidHino)
          .collection('notas')
          .get();

      return snapshot.docs
          .map<NotasModel>((nota) => NotasModel.fromDocumentSnapshot(nota))
          .toList();
    } on FirebaseException catch (e, s) {
      log('erro ao resgatar notas', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message: 'Oopss.. Erro inesperado. Tente novamente mais tarde.');
    }
  }

  @override
  Future<TimesModel> getTimesById(String uidTime) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshotTime =
          await FirebaseFirestore.instance
              .collection(mainCollection)
              .doc(uidTime)
              .get();

      final data = snapshotTime;
      return TimesModel.fromDocumentSnapshot(data);
    } on FirebaseException catch (e, s) {
      log('erro ao buscar hinos', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message: 'Erro ao carregar dados. Tente novamente mais tarde.');
    }
  }
}
