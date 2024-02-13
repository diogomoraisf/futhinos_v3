import 'package:flutter/material.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  var isOpen = false;

  void showLoader({String? message}) {
    if (!isOpen) {
      isOpen = true;
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (context) => Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.twistingDots(
                    leftDotColor: ThemeColors.yellowPadrao,
                    rightDotColor: Colors.black,
                    size: 50),
                message != null
                    ? Text(message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: ThemeColors.yellowPadrao,
                            fontSize: 16,
                            decoration: TextDecoration.none))
                    : Container()
              ],
            ),
          ),
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
