// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clube_ranking_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ClubeRankingStateStatusMatch on ClubeRankingStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() gettingTime,
      required T Function() gettedTime,
      required T Function() error}) {
    final v = this;
    if (v == ClubeRankingStateStatus.initial) {
      return initial();
    }

    if (v == ClubeRankingStateStatus.loading) {
      return loading();
    }

    if (v == ClubeRankingStateStatus.loaded) {
      return loaded();
    }

    if (v == ClubeRankingStateStatus.gettingTime) {
      return gettingTime();
    }

    if (v == ClubeRankingStateStatus.gettedTime) {
      return gettedTime();
    }

    if (v == ClubeRankingStateStatus.error) {
      return error();
    }

    throw Exception(
        'ClubeRankingStateStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? gettingTime,
      T Function()? gettedTime,
      T Function()? error}) {
    final v = this;
    if (v == ClubeRankingStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == ClubeRankingStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == ClubeRankingStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == ClubeRankingStateStatus.gettingTime && gettingTime != null) {
      return gettingTime();
    }

    if (v == ClubeRankingStateStatus.gettedTime && gettedTime != null) {
      return gettedTime();
    }

    if (v == ClubeRankingStateStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
