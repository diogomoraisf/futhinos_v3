import 'package:flutter/material.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';

Widget image(String asset) {
  return Image.asset(
    asset,
    height: 10.0,
    width: 10.0,
    color: ThemeColors.yellowPadrao,
  );
}
