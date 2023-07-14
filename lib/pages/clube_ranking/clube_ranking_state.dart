// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:futhinos_v2/models/ranking_model.dart';
import 'package:futhinos_v2/models/times_model.dart';

part 'clube_ranking_state.g.dart';

@match
enum ClubeRankingStateStatus {
  initial,
  loading,
  loaded,
  gettingTime,
  gettedTime,
  error
}

class ClubeRankingState extends Equatable {
  ClubeRankingStateStatus status;
  List<RankingModel> listaRanking;
  TimesModel time;
  String? errorMessage;
  ClubeRankingState({
    required this.status,
    required this.listaRanking,
    required this.time,
    this.errorMessage,
  });

  ClubeRankingState.initial()
      : status = ClubeRankingStateStatus.initial,
        listaRanking = [],
        time = TimesModel(nomeTime: ''),
        errorMessage = null;

  @override
  List<Object?> get props => [status, listaRanking, time, errorMessage];

  ClubeRankingState copyWith({
    ClubeRankingStateStatus? status,
    List<RankingModel>? listaRanking,
    TimesModel? time,
    String? errorMessage,
  }) {
    return ClubeRankingState(
      status: status ?? this.status,
      listaRanking: listaRanking ?? this.listaRanking,
      time: time ?? this.time,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
