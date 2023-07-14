import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:futhinos_v2/core/exceptions/respository_exceptions.dart';
import 'package:futhinos_v2/repositories/details/details_repository.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:new_version_plus/new_version_plus.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  @override
  Future<bool> openMailto(String emailDestino, String subjetc) async {
    String email = Uri.encodeComponent(emailDestino);
    String subject = Uri.encodeComponent(subjetc);
    String body = Uri.encodeComponent('');

    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");

    try {
      return await launchUrl(mail);
    } on Exception catch (e, s) {
      log('erro ao enviar email', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message: 'Oops.. falha ao abrir aplicativo de email.');
    }
  }

  @override
  Future<void> openReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    try {
      inAppReview.openStoreListing();
    } on Exception catch (e, s) {
      log('erro ao abrir avaliação', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message:
              'Oops.. ocorreu um erro ao abrir tela de avaliação. Tente novamente mais tarde');
    }
  }

  @override
  Future<void> shareApp(String message, String subject) async {
    try {
      await Share.share(message, subject: subject);
    } on Exception catch (e, s) {
      log('erro ao abrir o compartilhamento', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message: 'Erro ao tentar compartilhar. Tente novamente mais tarde');
    }
  }

  @override
  Future<VersionStatus> checkVersion() async {
    final newVersionPlus = NewVersionPlus();
    try {
      final status = await newVersionPlus.getVersionStatus();
      return status!;
    } on Exception catch (e, s) {
      log('erro ao checar versão instalada', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message: 'Erro ao verificar versão instalada do aplicativo');
    }
  }

  @override
  Future<void> updateVersion(
      VersionStatus status,
      BuildContext context,
      String dialogTitle,
      String dialogText,
      String updateButtonText,
      String dismissButtonText,
      void Function() dismissAction) async {
    final newVersionPlus = NewVersionPlus(androidPlayStoreCountry: 'pt_BR');
    try {
      if (Platform.isAndroid) {
        await InAppUpdate.checkForUpdate().then((value) {
          value.updateAvailability == UpdateAvailability.updateAvailable
              ? InAppUpdate.performImmediateUpdate()
              : null;
        }).catchError((e) {
          throw RespositoryExceptions(
              message:
                  'Não foi possível atualizar o aplicativo no momento. Tente novamente mais tarde');
        });
      } else {
        newVersionPlus.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: dialogTitle,
          dialogText: dialogText,
          updateButtonText: updateButtonText,
          dismissButtonText: dismissButtonText,
          dismissAction: () => dismissAction(),
        );
      }
    } on Exception catch (e, s) {
      log('Erro ao abrir atualizador do aplicativo', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message:
              'Não foi possível atualizar o aplicativo no momento. Tente novamente mais tarde');
    }
  }

  @override
  Future<bool> openLink(String linkUrl) async {
    final Uri url = Uri.parse(linkUrl);
    try {
      return await launchUrl(url);
    } on Exception catch (e, s) {
      log('erro ao abrir link externo', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message:
              'Erro ao carregar esta solicitação. Tente novamente mais tarde.');
    }
  }
}
