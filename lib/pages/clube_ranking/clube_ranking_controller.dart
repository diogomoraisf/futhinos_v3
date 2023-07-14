// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futhinos_v2/core/exceptions/respository_exceptions.dart';
import 'package:futhinos_v2/models/ranking_model.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/pages/clube_ranking/clube_ranking_state.dart';
import 'package:futhinos_v2/repositories/get_times/get_times_repository.dart';
import 'package:futhinos_v2/repositories/rated_hino/rated_repository.dart';

class ClubeRankingController extends Cubit<ClubeRankingState> {
  final RatedRepository _ratedRepository;

  final GetTimesRepository _getTimesRepository;
  ClubeRankingController(this._ratedRepository, this._getTimesRepository)
      : super(ClubeRankingState.initial());

  Future<void> getAllHinos() async {
    emit(state.copyWith(status: ClubeRankingStateStatus.loading));
    try {
      List<RankingModel> listaRanking = await _ratedRepository.getAllHinos();
      emit(state.copyWith(
          status: ClubeRankingStateStatus.loaded, listaRanking: listaRanking));
    } on RespositoryExceptions catch (e, s) {
      log('Erro ao buscar lista de todos os hinos', error: e, stackTrace: s);
      emit(state.copyWith(
          status: ClubeRankingStateStatus.error, errorMessage: e.message));
    }
  }

  Future<void> getTimeById(String uidTime) async {
    emit(state.copyWith(status: ClubeRankingStateStatus.gettingTime));
    try {
      TimesModel time = await _getTimesRepository.getTimesById(uidTime);
      emit(state.copyWith(
          status: ClubeRankingStateStatus.gettedTime, time: time));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao buscar time', error: e, stackTrace: s);
      emit(state.copyWith(
          status: ClubeRankingStateStatus.error, errorMessage: e.message));
    }
  }
}
