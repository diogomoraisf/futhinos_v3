import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';

abstract class DetailsRepository {
  Future<bool> openMailto(String emailDestino, String subject);
  Future<bool> openLink(String linkUrl);
  Future<void> openReview();
  Future<void> shareApp(String message, String subject);
  Future<VersionStatus> checkVersion();
  Future<void> updateVersion(
      VersionStatus status,
      BuildContext context,
      String dialogTitle,
      String dialogText,
      String updateButtonText,
      String dismissButtonText,
      void Function() dismissAction);
}
