import 'package:futhinos_v2/models/hinos_model.dart';

abstract class GetHinosRepository {
  Future<List<HinosModel>> getHinos(String uidTime);
  Future<String> readLetraHino(String urlLetra);
}
