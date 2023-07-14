import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futhinos_v2/core/exceptions/respository_exceptions.dart';
import 'package:futhinos_v2/core/styles/text_styles.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/pages/home/home_state.dart';
import 'package:futhinos_v2/pages/home/widgets/title_search_bar.dart';
import 'package:futhinos_v2/repositories/get_times/get_times_repository.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class HomeController extends Cubit<HomeState> {
  final GetTimesRepository _getHinosRepository;

  HomeController(this._getHinosRepository) : super(HomeState.initial());

  Future<void> createHinos(List<TimesModel> times) async {
    await _getHinosRepository.createBD(times);
  }

  Future<void> deleteHinos(List<TimesModel> times) async {
    await _getHinosRepository.deleteHinos(times);
  }

  Future<void> createOrderByHinos(List<TimesModel> listaTimes) async {
    await _getHinosRepository.createOrderByHinos(listaTimes);
  }

  Future<void> createQtdaHinos(List<TimesModel> listaTimes) async {
    await _getHinosRepository.createQtdaHinos(listaTimes);
  }

  Future<void> createNotaField(List<TimesModel> listaTimes) async {
    await _getHinosRepository.createNotaField(listaTimes);
  }

  Future<void> getTimes() async {
    emit(state.copyWith(status: HomePageStatus.loading));
    try {
      final listaTimes = await _getHinosRepository.getTimes();
      var choicesBrasilUF = _getHinosRepository.geListUF(listaTimes, 'brasil');
      var choicesMundoUF = _getHinosRepository.geListUF(listaTimes, 'mundo');
      emit(state.copyWith(
          status: HomePageStatus.loaded,
          listaTimes: listaTimes,
          filterTimes: listaTimes,
          choicesBrasilUF: choicesBrasilUF,
          choicesMundoUF: choicesMundoUF));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao buscar lista de times', error: e, stackTrace: s);
      emit(state.copyWith(
          status: HomePageStatus.error, errorMessage: e.message));
    }
  }

  Future<bool> checkConnection() async {
    return await InternetConnectionCheckerPlus().hasConnection;
  }

  selectedPage(currentIndex) {
    emit(state.copyWith(indexSelectedPage: currentIndex));
  }

  runFilter(List<TimesModel> allListTimes, String keyword) {
    List<TimesModel> results =
        _getHinosRepository.runFilter(allListTimes, keyword);
    emit(state.copyWith(status: HomePageStatus.loaded, filterTimes: results));
  }

  isSearch(bool iconIsSearch) {
    if (iconIsSearch) {
      Widget titleSearchBar =
          Text('FutHinos', style: TextStyles.instance.baseTitulo);
      emit(state.copyWith(
          iconIsSearch: !iconIsSearch,
          icon: Icons.search,
          titleSearchBar: titleSearchBar));
    } else {
      Widget titleSearchBar = const TitleSearchBar();
      emit(state.copyWith(
          iconIsSearch: !iconIsSearch,
          icon: Icons.cancel,
          titleSearchBar: titleSearchBar));
    }
  }

  updateFilterUF(String filterType, String filterKey) {
    if (filterType == 'brasil') {
      emit(state.copyWith(filterEstado: filterKey));
    } else {
      emit(state.copyWith(filterPais: filterKey));
    }
  }
}
