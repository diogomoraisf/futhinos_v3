import 'package:flutter/material.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

mixin Messages<T extends StatefulWidget> on State<T> {
  void showSuccess(String message) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message,
          maxLines: 3,
        ));
  }

  void showInfo(String message) {
    showTopSnackBar(
        Overlay.of(context),
        displayDuration: const Duration(seconds: 8),
        CustomSnackBar.info(
          message: message,
          maxLines: 3,
          backgroundColor: ThemeColors.yellowPadrao,
          textStyle: const TextStyle(color: ThemeColors.blackPadrao),
        ));
  }

  void showError(String message) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: message,
          maxLines: 3,
        ));
  }
}
