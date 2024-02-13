// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:futhinos_v2/services/globals.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:match/match.dart';

import 'package:futhinos_v2/models/hinos_model.dart';

part 'clube_profile_state.g.dart';

@match
enum ClubeProfileStateStatus {
  initial,
  loading,
  loaded,
  loadingRewardAd,
  loadedRewardAd,
  loadedRewarsAdFail,
  prepareDownload,
  downloading,
  downloaded,
  loadingRate,
  loadedRate,
  loadingRingtone,
  loadedRingtone,
  error
}

class ClubeProfileState extends Equatable {
  final ClubeProfileStateStatus status;
  final RewardedAd? rewardedAd;
  final int downloadCredits;
  final List<HinosModel> listaHinos;
  final String? errorMessage;
  const ClubeProfileState({
    required this.status,
    required this.listaHinos,
    required this.rewardedAd,
    required this.downloadCredits,
    this.errorMessage,
  });

  ClubeProfileState.initial()
      : status = ClubeProfileStateStatus.initial,
        listaHinos = [],
        downloadCredits = prefs.getInt('downloadCredits') ?? 0,
        rewardedAd = null,
        errorMessage = null;
  @override
  List<Object?> get props =>
      [status, listaHinos, downloadCredits, rewardedAd, errorMessage];

  ClubeProfileState copyWith({
    ClubeProfileStateStatus? status,
    RewardedAd? rewardedAd,
    int? downloadCredits,
    List<HinosModel>? listaHinos,
    String? errorMessage,
  }) {
    return ClubeProfileState(
      status: status ?? this.status,
      rewardedAd: rewardedAd ?? this.rewardedAd,
      downloadCredits: downloadCredits ?? this.downloadCredits,
      listaHinos: listaHinos ?? this.listaHinos,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
