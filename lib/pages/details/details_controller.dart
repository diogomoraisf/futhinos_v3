import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futhinos_v2/core/exceptions/respository_exceptions.dart';
import 'package:futhinos_v2/pages/details/details_state.dart';
import 'package:futhinos_v2/repositories/details/details_repository.dart';
import 'package:new_version_plus/new_version_plus.dart';

class DetailsController extends Cubit<DetailsState> {
  final DetailsRepository _detailsRepository;
  DetailsController(this._detailsRepository)
      : super(const DetailsState.initial());

  Future<void> openMailto(String emailDestino, String subject) async {
    emit(state.copyWith(status: DetailsStateStatus.openingEmail));
    try {
      await _detailsRepository.openMailto(emailDestino, subject);
      emit(state.copyWith(status: DetailsStateStatus.openedEmail));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao abrir aplicativo de email', error: e, stackTrace: s);
      emit(state.copyWith(
          status: DetailsStateStatus.error, errorMessage: e.message));
    }
  }

  Future<void> openLink(String linkUrl) async {
    emit(state.copyWith(status: DetailsStateStatus.openingLink));
    try {
      await _detailsRepository.openLink(linkUrl);
      emit(state.copyWith(status: DetailsStateStatus.openedLink));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao abrir link externo', error: e, stackTrace: s);
      emit(state.copyWith(
          status: DetailsStateStatus.error, errorMessage: e.message));
    }
  }

  Future<void> openReview() async {
    emit(state.copyWith(status: DetailsStateStatus.openingReview));
    try {
      await _detailsRepository.openReview();
      emit(state.copyWith(status: DetailsStateStatus.openedReview));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao abrir review de aplicativo', error: e, stackTrace: s);
      emit(state.copyWith(
          status: DetailsStateStatus.error, errorMessage: e.message));
    }
  }

  Future<void> shareApp(String message, String subject) async {
    emit(state.copyWith(status: DetailsStateStatus.openingShare));
    try {
      await _detailsRepository.shareApp(message, subject);
      emit(state.copyWith(status: DetailsStateStatus.openedShare));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao abrir share', error: e, stackTrace: s);
      emit(state.copyWith(
          status: DetailsStateStatus.error, errorMessage: e.message));
    }
  }

  Future<void> checkVersion() async {
    emit(state.copyWith(status: DetailsStateStatus.loadingCheckVersion));
    try {
      VersionStatus versionStatus = await _detailsRepository.checkVersion();
      emit(state.copyWith(
          status: DetailsStateStatus.loadedCheckVersion,
          versionStatus: versionStatus));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao verificar versão do aplicativo', error: e, stackTrace: s);
      emit(state.copyWith(
          status: DetailsStateStatus.error, errorMessage: e.message));
    }
  }

  Future<void> updateVersion(
      VersionStatus status,
      BuildContext context,
      String dialogTitle,
      String dialogText,
      String updateButtonText,
      String dismissButtonText,
      void Function() dismissAction) async {
    emit(state.copyWith(status: DetailsStateStatus.loadingUpdateVersion));
    try {
      await _detailsRepository.updateVersion(
          state.versionStatus!,
          context,
          dialogTitle,
          dialogText,
          updateButtonText,
          dismissButtonText,
          dismissAction);
      emit(state.copyWith(status: DetailsStateStatus.loadedUpdateVersion));
    } on RespositoryExceptions catch (e, s) {
      log('erro ao atualizar o aplicativo na loja', error: e, stackTrace: s);
      emit(state.copyWith(
          status: DetailsStateStatus.error, errorMessage: e.message));
    }
  }
}
