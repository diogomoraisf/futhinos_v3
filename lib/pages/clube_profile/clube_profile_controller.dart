import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futhinos_v2/core/exceptions/respository_exceptions.dart';
import 'package:futhinos_v2/models/hinos_model.dart';
import 'package:futhinos_v2/models/notas_model.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/pages/clube_profile/clube_profile_state.dart';
import 'package:futhinos_v2/repositories/download_hino/download_hino_repository.dart';
import 'package:futhinos_v2/repositories/get_hinos/get_hinos_repository.dart';
import 'package:futhinos_v2/repositories/rated_hino/rated_repository.dart';
import 'package:futhinos_v2/services/globals.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ringtone_set_mul/ringtone_set_mul.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClubeProfileController extends Cubit<ClubeProfileState> {
  final GetHinosRepository _getHinosRepository;
  final DownloadHinoRepository _downloadHinoRepository;
  final RatedRepository _ratedRepository;

  ClubeProfileController(this._getHinosRepository, this._downloadHinoRepository,
      this._ratedRepository)
      : super(ClubeProfileState.initial());

  Future<void> getHinos(String uidTime) async {
    emit(state.copyWith(status: ClubeProfileStateStatus.loading));
    try {
      var listaHinos = await _getHinosRepository.getHinos(uidTime);
      emit(state.copyWith(
          status: ClubeProfileStateStatus.loaded, listaHinos: listaHinos));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao obter lista de hinos', error: e, stackTrace: s);
      emit(state.copyWith(
          status: ClubeProfileStateStatus.error, errorMessage: e.message));
    }
  }

  Future<void> downloadHino(String urlHino, String fileName) async {
    emit(state.copyWith(status: ClubeProfileStateStatus.downloading));
    try {
      await _downloadHinoRepository.downloadHino(urlHino, fileName);
      await removeDownloadsCredits(10);
      emit(state.copyWith(
        status: ClubeProfileStateStatus.downloaded,
      ));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao realizar download do hino', error: e, stackTrace: s);
      emit(state.copyWith(
          status: ClubeProfileStateStatus.error,
          errorMessage: 'Erro inesperado. Tente novamente em outro momento'));
    }
  }

  Future<void> loadRewardedAd() async {
    emit(state.copyWith(status: ClubeProfileStateStatus.loadingRewardAd));
    try {
      await RewardedAd.load(
          adUnitId: Platform.isIOS
              ? "ca-app-pub-3940256099942544/1712485313"
              : "ca-app-pub-3037761772108066/9179170532", // id anuncio real
          //"ca-app-pub-3940256099942544/5224354917", // id anuncio de teste
          request: const AdRequest(),
          rewardedAdLoadCallback:
              RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
            showRewardedAd(ad);
          }, onAdFailedToLoad: (LoadAdError error) {
            showRewardedAd(null);
            emit(state.copyWith(
                status: ClubeProfileStateStatus.loadedRewarsAdFail));
          }));
      emit(state.copyWith(
        status: ClubeProfileStateStatus.loadedRewardAd,
      ));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao carregar rewardads', error: e, stackTrace: s);
      emit(state.copyWith(
          status: ClubeProfileStateStatus.error, errorMessage: e.message));
    }
  }

  Future<void> showRewardedAd(RewardedAd? rewardedAd) async {
    emit(state.copyWith(rewardedAd: rewardedAd));
  }

  Future<void> addDownloadsCredits(int credits) async {
    int downloadCredits = prefs.getInt('downloadCredits') ?? 0;
    await prefs.setInt('downloadCredits', downloadCredits + credits);
    emit(state.copyWith(downloadCredits: prefs.getInt('downloadCredits')));
  }

  Future<void> removeDownloadsCredits(int credits) async {
    int downloadCredits = prefs.getInt('downloadCredits') ?? 0;
    await prefs.setInt('downloadCredits', downloadCredits - credits);
    emit(state.copyWith(downloadCredits: prefs.getInt('downloadCredits')));
  }

  Future<List<NotasModel>> getRate(String uidTime, String uidHino) async {
    try {
      List<NotasModel> listaNotas =
          await _ratedRepository.getRate(uidTime, uidHino);
      return listaNotas;
    } on RespositoryExceptions catch (e, s) {
      log('erro ao adicionar nota', error: e, stackTrace: s);
      throw RespositoryExceptions(message: e.message);
    }
  }

  Future<double> calcRate(List<NotasModel> listaNotas) async {
    try {
      double notaRate = _ratedRepository.calcRate(listaNotas);
      return notaRate;
    } on RespositoryExceptions catch (e, s) {
      log('erro ao calcular nota', error: e, stackTrace: s);
      throw RespositoryExceptions(message: e.message);
    }
  }

  Future<void> saveRate(
      {required HinosModel hino,
      required TimesModel time,
      required String uidTime,
      required String uidHino,
      required double nota}) async {
    emit(state.copyWith(status: ClubeProfileStateStatus.loadingRate));
    try {
      String uidNota = await _ratedRepository.saveRate(uidTime, uidHino, nota);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataNota = NotasModel(
        uidNota: uidNota,
        nota: nota,
      ).toMap();
      await prefs.setString(uidHino, jsonEncode(dataNota));
      List<NotasModel> listaNotas = await getRate(uidTime, uidHino);
      double notaMedia = await calcRate(listaNotas);
      await _ratedRepository.setRate(uidTime, uidHino, notaMedia);
      await _ratedRepository.saveRanking(hino, time, listaNotas, notaMedia);
      var listaHinos = await _getHinosRepository.getHinos(uidTime);
      emit(state.copyWith(
          status: ClubeProfileStateStatus.loadedRate, listaHinos: listaHinos));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao adicionar nota', error: e, stackTrace: s);
      emit(state.copyWith(
          status: ClubeProfileStateStatus.error, errorMessage: e.message));
    }
  }

  Future<void> updateRate(
      {required HinosModel hino,
      required TimesModel time,
      required String uidTime,
      required String uidHino,
      required String uidNota,
      required double nota}) async {
    emit(state.copyWith(status: ClubeProfileStateStatus.loadingRate));
    try {
      await _ratedRepository.updateRate(uidTime, uidHino, uidNota, nota);
      List<NotasModel> listaNotas = await getRate(uidTime, uidHino);
      double notaMedia = await calcRate(listaNotas);
      await _ratedRepository.setRate(uidTime, uidHino, notaMedia);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final dataNota = NotasModel(
        uidNota: uidNota,
        nota: nota,
      ).toMap();
      await prefs.setString(uidHino, jsonEncode(dataNota));
      await prefs.reload();
      await _ratedRepository.saveRanking(hino, time, listaNotas, notaMedia);
      var listaHinos = await _getHinosRepository.getHinos(uidTime);
      emit(state.copyWith(
          status: ClubeProfileStateStatus.loadedRate, listaHinos: listaHinos));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao atualizar nota', error: e, stackTrace: s);
      emit(state.copyWith(
          status: ClubeProfileStateStatus.error, errorMessage: e.message));
    }
  }

  Future<void> saveNotaMedia(String uidTime, String uidHino) async {
    List<NotasModel> listaNotas = await getRate(uidTime, uidHino);
    double notaMedia = await calcRate(listaNotas);
    try {
      await _ratedRepository.setRate(uidTime, uidHino, notaMedia);
    } on RespositoryExceptions catch (e, s) {
      log('erro ao salvar notaMedia', error: e, stackTrace: s);
      emit(state.copyWith(
          status: ClubeProfileStateStatus.error, errorMessage: e.message));
    }
  }

  Future<void> addRingtone(String urlHino) async {
    emit(state.copyWith(status: ClubeProfileStateStatus.loadingRingtone));
    try {
      await RingtoneSet.setRingtoneFromNetwork(urlHino);
      emit(state.copyWith(status: ClubeProfileStateStatus.loadedRingtone));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao adicionar ringtone', error: e, stackTrace: s);
      emit(state.copyWith(
          status: ClubeProfileStateStatus.error,
          errorMessage: 'Oopss.. Erro inesperado. Tente novamente mais tarde'));
    }
  }
}
