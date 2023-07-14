// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension HomePageStatusMatch on HomePageStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() checkingInternet,
      required T Function() checkedInternet,
      required T Function() loadingBannerAd,
      required T Function() loadedBannerAd,
      required T Function() loadingNativeAd,
      required T Function() loadedNativeAd,
      required T Function() error}) {
    final v = this;
    if (v == HomePageStatus.initial) {
      return initial();
    }

    if (v == HomePageStatus.loading) {
      return loading();
    }

    if (v == HomePageStatus.loaded) {
      return loaded();
    }

    if (v == HomePageStatus.checkingInternet) {
      return checkingInternet();
    }

    if (v == HomePageStatus.checkedInternet) {
      return checkedInternet();
    }

    if (v == HomePageStatus.loadingBannerAd) {
      return loadingBannerAd();
    }

    if (v == HomePageStatus.loadedBannerAd) {
      return loadedBannerAd();
    }

    if (v == HomePageStatus.loadingNativeAd) {
      return loadingNativeAd();
    }

    if (v == HomePageStatus.loadedNativeAd) {
      return loadedNativeAd();
    }

    if (v == HomePageStatus.error) {
      return error();
    }

    throw Exception('HomePageStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? checkingInternet,
      T Function()? checkedInternet,
      T Function()? loadingBannerAd,
      T Function()? loadedBannerAd,
      T Function()? loadingNativeAd,
      T Function()? loadedNativeAd,
      T Function()? error}) {
    final v = this;
    if (v == HomePageStatus.initial && initial != null) {
      return initial();
    }

    if (v == HomePageStatus.loading && loading != null) {
      return loading();
    }

    if (v == HomePageStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == HomePageStatus.checkingInternet && checkingInternet != null) {
      return checkingInternet();
    }

    if (v == HomePageStatus.checkedInternet && checkedInternet != null) {
      return checkedInternet();
    }

    if (v == HomePageStatus.loadingBannerAd && loadingBannerAd != null) {
      return loadingBannerAd();
    }

    if (v == HomePageStatus.loadedBannerAd && loadedBannerAd != null) {
      return loadedBannerAd();
    }

    if (v == HomePageStatus.loadingNativeAd && loadingNativeAd != null) {
      return loadingNativeAd();
    }

    if (v == HomePageStatus.loadedNativeAd && loadedNativeAd != null) {
      return loadedNativeAd();
    }

    if (v == HomePageStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
