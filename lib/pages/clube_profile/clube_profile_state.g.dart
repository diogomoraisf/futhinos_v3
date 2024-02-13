// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clube_profile_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ClubeProfileStateStatusMatch on ClubeProfileStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() loadingRewardAd,
      required T Function() loadedRewardAd,
      required T Function() loadedRewarsAdFail,
      required T Function() prepareDownload,
      required T Function() downloading,
      required T Function() downloaded,
      required T Function() loadingRate,
      required T Function() loadedRate,
      required T Function() loadingRingtone,
      required T Function() loadedRingtone,
      required T Function() error}) {
    final v = this;
    if (v == ClubeProfileStateStatus.initial) {
      return initial();
    }

    if (v == ClubeProfileStateStatus.loading) {
      return loading();
    }

    if (v == ClubeProfileStateStatus.loaded) {
      return loaded();
    }

    if (v == ClubeProfileStateStatus.loadingRewardAd) {
      return loadingRewardAd();
    }

    if (v == ClubeProfileStateStatus.loadedRewardAd) {
      return loadedRewardAd();
    }

    if (v == ClubeProfileStateStatus.loadedRewarsAdFail) {
      return loadedRewarsAdFail();
    }

    if (v == ClubeProfileStateStatus.prepareDownload) {
      return prepareDownload();
    }

    if (v == ClubeProfileStateStatus.downloading) {
      return downloading();
    }

    if (v == ClubeProfileStateStatus.downloaded) {
      return downloaded();
    }

    if (v == ClubeProfileStateStatus.loadingRate) {
      return loadingRate();
    }

    if (v == ClubeProfileStateStatus.loadedRate) {
      return loadedRate();
    }

    if (v == ClubeProfileStateStatus.loadingRingtone) {
      return loadingRingtone();
    }

    if (v == ClubeProfileStateStatus.loadedRingtone) {
      return loadedRingtone();
    }

    if (v == ClubeProfileStateStatus.error) {
      return error();
    }

    throw Exception(
        'ClubeProfileStateStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? loadingRewardAd,
      T Function()? loadedRewardAd,
      T Function()? loadedRewarsAdFail,
      T Function()? prepareDownload,
      T Function()? downloading,
      T Function()? downloaded,
      T Function()? loadingRate,
      T Function()? loadedRate,
      T Function()? loadingRingtone,
      T Function()? loadedRingtone,
      T Function()? error}) {
    final v = this;
    if (v == ClubeProfileStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == ClubeProfileStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == ClubeProfileStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == ClubeProfileStateStatus.loadingRewardAd &&
        loadingRewardAd != null) {
      return loadingRewardAd();
    }

    if (v == ClubeProfileStateStatus.loadedRewardAd && loadedRewardAd != null) {
      return loadedRewardAd();
    }

    if (v == ClubeProfileStateStatus.loadedRewarsAdFail &&
        loadedRewarsAdFail != null) {
      return loadedRewarsAdFail();
    }

    if (v == ClubeProfileStateStatus.prepareDownload &&
        prepareDownload != null) {
      return prepareDownload();
    }

    if (v == ClubeProfileStateStatus.downloading && downloading != null) {
      return downloading();
    }

    if (v == ClubeProfileStateStatus.downloaded && downloaded != null) {
      return downloaded();
    }

    if (v == ClubeProfileStateStatus.loadingRate && loadingRate != null) {
      return loadingRate();
    }

    if (v == ClubeProfileStateStatus.loadedRate && loadedRate != null) {
      return loadedRate();
    }

    if (v == ClubeProfileStateStatus.loadingRingtone &&
        loadingRingtone != null) {
      return loadingRingtone();
    }

    if (v == ClubeProfileStateStatus.loadedRingtone && loadedRingtone != null) {
      return loadedRingtone();
    }

    if (v == ClubeProfileStateStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
