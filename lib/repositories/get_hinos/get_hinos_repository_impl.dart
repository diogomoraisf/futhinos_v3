import 'dart:convert';
import 'dart:developer';
import 'package:futhinos_v2/services/globals.dart';
import 'package:html/parser.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:futhinos_v2/core/exceptions/respository_exceptions.dart';
import 'package:futhinos_v2/models/hinos_model.dart';

import './get_hinos_repository.dart';
import 'package:futhinos_v2/services/globals.dart' as globals;

class GetHinosRepositoryImpl implements GetHinosRepository {
  @override
  Future<List<HinosModel>> getHinos(String uidTime) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection(mainCollection)
          .doc(uidTime)
          .collection('hinos')
          .orderBy("ordem", descending: false)
          .get();

      return snapshot.docs
          .map<HinosModel>(
              (listaHinos) => HinosModel.fromDocumentSnapshot(listaHinos))
          .toList();
    } on FirebaseException catch (e, s) {
      log('erro ao buscar lista de hinos', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message: 'Erro inesperado. Tente novamente mais tarde');
    }
  }

  @override
  Future<String> readLetraHino(String urlLetra) async {
    String letraHino;
    try {
      String urlLetraHino = globals.baseUrl + urlLetra;
      final getFileLetra =
          await DefaultCacheManager().getSingleFile(urlLetraHino);
      var htmlString = await getFileLetra.readAsString(
          encoding: Encoding.getByName('LATIN1')!);
      var document = parse(htmlString);
      letraHino = parse(document.body!.text).documentElement!.text;
      return letraHino;
    } on Exception catch (e, s) {
      log('erro ao buscar letra do hino', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message:
              'Oops.. Um erro inesperado ocorreu. Tente novamente mais tarde.');
    }
  }
}
