import 'package:futhinos_v2/models/hinos_model.dart';
import 'package:futhinos_v2/models/notas_model.dart';
import 'package:futhinos_v2/models/ranking_model.dart';
import 'package:futhinos_v2/models/times_model.dart';

abstract class RatedRepository {
  Future<String> saveRate(String uidTime, String uidHino, double nota);
  Future<void> updateRate(
      String uidTime, String uidHino, String uidNota, double nota);
  Future<List<NotasModel>> getRate(String uidTime, String uidHino);
  double calcRate(List<NotasModel> listaNotas);
  Future<void> setRate(String uidTime, String uidHino, double notaMedia);
  Future<List<RankingModel>> getAllHinos();
  Future<void> saveRanking(HinosModel hino, TimesModel time,
      List<NotasModel> listaNotas, double notaMedia);
}
