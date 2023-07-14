import 'package:futhinos_v2/models/times_model.dart';

abstract class GetTimesRepository {
  Future<List<TimesModel>> getTimes();
  Future<TimesModel> getTimesById(String uidTime);
  Future<void> createBD(List<TimesModel> times);
  Future<void> createOrderByHinos(List<TimesModel> listaTimes);
  Future<void> createQtdaHinos(List<TimesModel> listaTimes);
  Future<void> createNotaField(List<TimesModel> listaTimes);
  Future<void> deleteHinos(List<TimesModel> times);
  List<TimesModel> runFilter(List<TimesModel> allListTimes, String keyword);
  List<String> geListUF(List<TimesModel> listaTimes, String filterType);
}
