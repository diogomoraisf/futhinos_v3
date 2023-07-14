import 'package:flutter/material.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/pages/clube_profile/widgets/social_media_buttom.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaBar extends StatelessWidget {
  final TimesModel time;

  const SocialMediaBar({super.key, required this.time});

  void abrirInstagram(String redeSocial) async {
    String socialURL = '';
    switch (redeSocial) {
      case 'twitter':
        socialURL = 'https://twitter.com/${time.twitter}';
        break;
      case 'facebook':
        socialURL = 'https://facebook.com/${time.facebook}';
        break;
      case 'instagram':
        socialURL = 'https://instagram.com/${time.instagram}';
        break;
      default:
    }

    if (await canLaunchUrl(Uri.parse(socialURL))) {
      await launchUrl(Uri.parse(socialURL));
    } else {
      throw 'Could not launch $socialURL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            (time.twitter!.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: SocialMediaButtom(
                        socialMedia: 'twitter', destino: abrirInstagram),
                  )
                : Container(),
            (time.instagram!.isNotEmpty)
                ? SocialMediaButtom(
                    socialMedia: 'instagram',
                    destino: abrirInstagram,
                  )
                : Container(),
            (time.facebook != '')
                ? SocialMediaButtom(
                    socialMedia: 'facebook', destino: abrirInstagram)
                : Container(),
          ],
        ),
      ),
    );
  }
}
