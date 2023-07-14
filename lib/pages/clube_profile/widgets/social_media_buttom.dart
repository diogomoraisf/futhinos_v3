import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';

class SocialMediaButtom extends StatelessWidget {
  final String socialMedia;
  final void Function(String redeSocial) destino;
  const SocialMediaButtom(
      {super.key, required this.socialMedia, required this.destino});

  @override
  Widget build(BuildContext context) {
    IconData? icon;
    Color? cor;
    switch (socialMedia) {
      case 'twitter':
        cor = ThemeColors.twitter;
        icon = FontAwesomeIcons.twitter;
        break;
      case 'facebook':
        cor = ThemeColors.facebook;
        icon = FontAwesomeIcons.facebook;
        break;
      case 'instagram':
        cor = ThemeColors.instagram;
        icon = FontAwesomeIcons.instagram;
        break;
      default:
    }
    return RawMaterialButton(
      constraints: BoxConstraints.tight(const Size(38, 38)),
      elevation: 4.0,
      fillColor: cor,
      padding: const EdgeInsets.all(0),
      shape: const CircleBorder(),
      onPressed: () {
        destino(socialMedia);
      },
      child: Icon(
        icon,
        size: 14,
        color: Colors.white,
      ),
    );
  }
}
