import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:futhinos_v2/core/exceptions/respository_exceptions.dart';
import 'package:futhinos_v2/pages/letra_hino.dart/letra_hino_state.dart';
import 'package:futhinos_v2/repositories/get_hinos/get_hinos_repository.dart';

class LetraHinoController extends Cubit<LetraHinoState> {
  final GetHinosRepository _getHinosRepository;
  LetraHinoController(this._getHinosRepository)
      : super(const LetraHinoState.initial());

  Future<void> readLetraHino(String urlLetra) async {
    emit(state.copyWith(status: LetraHinoStateStatus.loading));
    try {
      String letraHino = await _getHinosRepository.readLetraHino(urlLetra);
      emit(state.copyWith(
          status: LetraHinoStateStatus.loaded, letraHino: letraHino));
    } on RespositoryExceptions catch (e, s) {
      log('Erro ao buscar letra do hino', error: e, stackTrace: s);
      emit(state.copyWith(
          status: LetraHinoStateStatus.error, errorMessage: e.message));
    }
  }
}
