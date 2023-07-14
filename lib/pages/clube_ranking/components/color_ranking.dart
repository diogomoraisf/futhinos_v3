import 'package:flutter/material.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';

class ColorRanking {
  static Color getBackgroundColor(int index) {
    switch (index) {
      case 1:
        return ThemeColors.yellowPadrao;
      case 2:
        return Colors.blueGrey.shade100;
      case 3:
        return Colors.brown.shade400;
      default:
        return Colors.white;
    }
  }

  static Color getForegroundColor(int index) {
    switch (index) {
      case 1:
        return ThemeColors.blackPadrao;
      case 2:
        return ThemeColors.blackPadrao;
      case 3:
        return Colors.white;
      default:
        return ThemeColors.blackPadrao;
    }
  }
}
