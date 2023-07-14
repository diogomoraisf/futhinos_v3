// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension DetailsStateStatusMatch on DetailsStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loadingCheckVersion,
      required T Function() loadingUpdateVersion,
      required T Function() loadedUpdateVersion,
      required T Function() loadedCheckVersion,
      required T Function() openingEmail,
      required T Function() openedEmail,
      required T Function() openingReview,
      required T Function() openedReview,
      required T Function() openingShare,
      required T Function() openedShare,
      required T Function() openingLink,
      required T Function() openedLink,
      required T Function() error}) {
    final v = this;
    if (v == DetailsStateStatus.initial) {
      return initial();
    }

    if (v == DetailsStateStatus.loadingCheckVersion) {
      return loadingCheckVersion();
    }

    if (v == DetailsStateStatus.loadingUpdateVersion) {
      return loadingUpdateVersion();
    }

    if (v == DetailsStateStatus.loadedUpdateVersion) {
      return loadedUpdateVersion();
    }

    if (v == DetailsStateStatus.loadedCheckVersion) {
      return loadedCheckVersion();
    }

    if (v == DetailsStateStatus.openingEmail) {
      return openingEmail();
    }

    if (v == DetailsStateStatus.openedEmail) {
      return openedEmail();
    }

    if (v == DetailsStateStatus.openingReview) {
      return openingReview();
    }

    if (v == DetailsStateStatus.openedReview) {
      return openedReview();
    }

    if (v == DetailsStateStatus.openingShare) {
      return openingShare();
    }

    if (v == DetailsStateStatus.openedShare) {
      return openedShare();
    }

    if (v == DetailsStateStatus.openingLink) {
      return openingLink();
    }

    if (v == DetailsStateStatus.openedLink) {
      return openedLink();
    }

    if (v == DetailsStateStatus.error) {
      return error();
    }

    throw Exception(
        'DetailsStateStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loadingCheckVersion,
      T Function()? loadingUpdateVersion,
      T Function()? loadedUpdateVersion,
      T Function()? loadedCheckVersion,
      T Function()? openingEmail,
      T Function()? openedEmail,
      T Function()? openingReview,
      T Function()? openedReview,
      T Function()? openingShare,
      T Function()? openedShare,
      T Function()? openingLink,
      T Function()? openedLink,
      T Function()? error}) {
    final v = this;
    if (v == DetailsStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == DetailsStateStatus.loadingCheckVersion &&
        loadingCheckVersion != null) {
      return loadingCheckVersion();
    }

    if (v == DetailsStateStatus.loadingUpdateVersion &&
        loadingUpdateVersion != null) {
      return loadingUpdateVersion();
    }

    if (v == DetailsStateStatus.loadedUpdateVersion &&
        loadedUpdateVersion != null) {
      return loadedUpdateVersion();
    }

    if (v == DetailsStateStatus.loadedCheckVersion &&
        loadedCheckVersion != null) {
      return loadedCheckVersion();
    }

    if (v == DetailsStateStatus.openingEmail && openingEmail != null) {
      return openingEmail();
    }

    if (v == DetailsStateStatus.openedEmail && openedEmail != null) {
      return openedEmail();
    }

    if (v == DetailsStateStatus.openingReview && openingReview != null) {
      return openingReview();
    }

    if (v == DetailsStateStatus.openedReview && openedReview != null) {
      return openedReview();
    }

    if (v == DetailsStateStatus.openingShare && openingShare != null) {
      return openingShare();
    }

    if (v == DetailsStateStatus.openedShare && openedShare != null) {
      return openedShare();
    }

    if (v == DetailsStateStatus.openingLink && openingLink != null) {
      return openingLink();
    }

    if (v == DetailsStateStatus.openedLink && openedLink != null) {
      return openedLink();
    }

    if (v == DetailsStateStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
