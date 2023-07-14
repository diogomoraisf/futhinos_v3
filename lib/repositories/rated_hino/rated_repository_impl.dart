import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futhinos_v2/core/exceptions/respository_exceptions.dart';
import 'package:futhinos_v2/models/hinos_model.dart';
import 'package:futhinos_v2/models/notas_model.dart';
import 'package:futhinos_v2/models/ranking_model.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/repositories/rated_hino/rated_repository.dart';
import 'package:futhinos_v2/services/globals.dart';

class RatedRepositoryImpl implements RatedRepository {
  @override
  Future<String> saveRate(String uidTime, String uidHino, double nota) async {
    var dadosNota = {
      'nota': nota,
      'dataCriacao': FieldValue.serverTimestamp(),
      'dataModificacao': FieldValue.serverTimestamp()
    };
    try {
      var addNewNota = FirebaseFirestore.instance
          .collection(mainCollection)
          .doc(uidTime)
          .collection('hinos')
          .doc(uidHino)
          .collection('notas')
          .doc();

      await addNewNota.set(dadosNota);
      return addNewNota.id;
    } on FirebaseException catch (e, s) {
      log('erro ao incluir nota', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message: 'Oopss.. Erro ao incluir nota. Tente novamente mais tarde.');
    }
  }

  @override
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

  @override
  Future<void> updateRate(
      String uidTime, String uidHino, String uidNota, double nota) async {
    try {
      await FirebaseFirestore.instance
          .collection(mainCollection)
          .doc(uidTime)
          .collection('hinos')
          .doc(uidHino)
          .collection('notas')
          .doc(uidNota)
          .update(
              {'nota': nota, 'dataModificacao': FieldValue.serverTimestamp()});
    } on FirebaseFirestore catch (e, s) {
      log('erro ao atualizar nota', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message: 'Oopss.. Erro inesperado. Tente novamente mais tarde.');
    }
  }

  @override
  Future<void> setRate(String uidTime, String uidHino, double notaMedia) async {
    try {
      await FirebaseFirestore.instance
          .collection(mainCollection)
          .doc(uidTime)
          .collection('hinos')
          .doc(uidHino)
          .set({'notaMedia': notaMedia}, SetOptions(merge: true));
    } on FirebaseException catch (e, s) {
      log('erro ao savar nota media', error: e, stackTrace: s);
      throw RespositoryExceptions(message: 'Erro inesperado.');
    }
  }

  @override
  Future<void> saveRanking(HinosModel hino, TimesModel time,
      List<NotasModel> listaNotas, double notaMedia) async {
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

  @override
  Future<List<RankingModel>> getAllHinos() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshotRanking =
          await FirebaseFirestore.instance
              .collection('ranking')
              .orderBy('notaMedia', descending: true)
              .orderBy('qtdaNotas', descending: true)
              .orderBy('nomeTime', descending: false)
              .get();
      List<RankingModel> listaRanking = snapshotRanking.docs
          .map<RankingModel>(
              (listaHinos) => RankingModel.fromDocumentSnapshot(listaHinos))
          .toList();
      return listaRanking;
    } on FirebaseException catch (e, s) {
      log('erro ao buscar ranking', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message: 'Erro inesperado. Tente novamente mais tarde');
    }
  }
}
