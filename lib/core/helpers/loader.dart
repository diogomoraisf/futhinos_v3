import 'package:flutter/material.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  var isOpen = false;

  void showLoader() {
    if (!isOpen) {
      isOpen = true;
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (context) => Center(
          child: LoadingAnimationWidget.twistingDots(
              leftDotColor: ThemeColors.yellowPadrao,
              rightDotColor: Colors.black,
              size: 50),
        ),
      );
    }
  }

  void hideLoader() {
    if (isOpen) {
      isOpen = false;
      Navigator.of(context).pop();
    }
  }
}
