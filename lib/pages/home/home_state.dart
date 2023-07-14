// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:match/match.dart';

import 'package:futhinos_v2/core/styles/text_styles.dart';
import 'package:futhinos_v2/models/times_model.dart';

part 'home_state.g.dart';

@match
enum HomePageStatus {
  initial,
  loading,
  loaded,
  checkingInternet,
  checkedInternet,
  loadingBannerAd,
  loadedBannerAd,
  loadingNativeAd,
  loadedNativeAd,
  error
}

class HomeState extends Equatable {
  final HomePageStatus status;
  final BannerAd? bannerAd;
  final NativeAd? nativeAd;
  final List<TimesModel> listaTimes;
  final List<TimesModel> filterTimes;
  final bool iconIsSearch;
  final IconData icon;
  final Widget titleSearchBar;
  final int indexSelectedPage;
  final List<String> choicesBrasilUF;
  final List<String> choicesMundoUF;
  final String filterEstado;
  final String filterPais;
  final String? errorMessage;

  const HomeState(
      {required this.status,
      required this.listaTimes,
      required this.filterTimes,
      required this.iconIsSearch,
      required this.icon,
      required this.titleSearchBar,
      required this.indexSelectedPage,
      required this.choicesBrasilUF,
      required this.choicesMundoUF,
      required this.filterEstado,
      required this.filterPais,
      required this.bannerAd,
      required this.nativeAd,
      this.errorMessage});
  HomeState.initial()
      : status = HomePageStatus.initial,
        errorMessage = null,
        iconIsSearch = false,
        bannerAd = null,
        nativeAd = null,
        icon = Icons.search,
        listaTimes = [],
        filterTimes = [],
        choicesBrasilUF = [],
        choicesMundoUF = [],
        indexSelectedPage = 0,
        filterEstado = 'all',
        filterPais = 'all',
        titleSearchBar =
            Text('FutHinos', style: TextStyles.instance.baseTitulo);
  @override
  List<Object?> get props => [
        status,
        listaTimes,
        bannerAd,
        nativeAd,
        filterTimes,
        choicesBrasilUF,
        choicesMundoUF,
        iconIsSearch,
        icon,
        titleSearchBar,
        indexSelectedPage,
        filterEstado,
        filterPais,
        errorMessage
      ];

  HomeState copyWith({
    HomePageStatus? status,
    BannerAd? bannerAd,
    NativeAd? nativeAd,
    List<TimesModel>? listaTimes,
    List<TimesModel>? filterTimes,
    bool? iconIsSearch,
    IconData? icon,
    Widget? titleSearchBar,
    int? indexSelectedPage,
    List<String>? choicesBrasilUF,
    List<String>? choicesMundoUF,
    String? filterEstado,
    String? filterPais,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      bannerAd: bannerAd ?? this.bannerAd,
      nativeAd: nativeAd ?? this.nativeAd,
      listaTimes: listaTimes ?? this.listaTimes,
      filterTimes: filterTimes ?? this.filterTimes,
      iconIsSearch: iconIsSearch ?? this.iconIsSearch,
      icon: icon ?? this.icon,
      titleSearchBar: titleSearchBar ?? this.titleSearchBar,
      indexSelectedPage: indexSelectedPage ?? this.indexSelectedPage,
      choicesBrasilUF: choicesBrasilUF ?? this.choicesBrasilUF,
      choicesMundoUF: choicesMundoUF ?? this.choicesMundoUF,
      filterEstado: filterEstado ?? this.filterEstado,
      filterPais: filterPais ?? this.filterPais,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
