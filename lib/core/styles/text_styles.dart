import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instace;

  TextStyles._();

  static TextStyles get instance {
    _instace ??= TextStyles._();
    return _instace!;
  }

  String get font => "SourceSansPro";

  TextStyle get baseTitulo => TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20,
      color: Colors.white,
      fontFamily: font);
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}
