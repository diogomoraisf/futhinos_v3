import 'package:flutter/material.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';
import 'package:futhinos_v2/models/times_model.dart';

class LetraHinoButtom extends StatelessWidget {
  final TimesModel time;
  const LetraHinoButtom({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(color: Colors.black),
              backgroundColor: ThemeColors.yellowPadrao,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
          onPressed: () {
            Navigator.of(context)
                .pushNamed('letraHino', arguments: {'time': time});
          },
          child: const Padding(
              padding:
                  EdgeInsets.only(left: 5.0, right: 5.0, top: 5, bottom: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.queue_music_sharp,
                    color: Colors.black,
                  ),
                  VerticalDivider(
                    width: 10,
                  ),
                  Text(
                    'Letra do Hino Oficial',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ))),
    );
  }
}
