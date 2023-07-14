// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letra_hino_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension LetraHinoStateStatusMatch on LetraHinoStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == LetraHinoStateStatus.initial) {
      return initial();
    }

    if (v == LetraHinoStateStatus.loading) {
      return loading();
    }

    if (v == LetraHinoStateStatus.loaded) {
      return loaded();
    }

    if (v == LetraHinoStateStatus.error) {
      return error();
    }

    throw Exception(
        'LetraHinoStateStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == LetraHinoStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == LetraHinoStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == LetraHinoStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == LetraHinoStateStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
