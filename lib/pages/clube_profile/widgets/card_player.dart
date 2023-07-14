import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';
import 'package:futhinos_v2/core/widgets/rating_image.dart';
import 'package:futhinos_v2/models/hinos_model.dart';
import 'package:futhinos_v2/models/notas_model.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/pages/clube_profile/clube_profile_controller.dart';
import 'package:futhinos_v2/pages/clube_profile/clube_profile_state.dart';
import 'package:futhinos_v2/pages/clube_profile/components/audio_player.dart';
import 'package:futhinos_v2/core/helpers/double_no_round.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:futhinos_v2/services/globals.dart' as globals;
import 'package:vs_scrollbar/vs_scrollbar.dart';

class CardPlayer extends StatefulWidget {
  final List<HinosModel> listaHinos;
  final TimesModel time;
  final ClubeProfileController controller;
  const CardPlayer(
      {super.key,
      required this.listaHinos,
      required this.time,
      required this.controller});

  @override
  State<CardPlayer> createState() => _CardPlayerState();
}

class _CardPlayerState extends State<CardPlayer> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClubeProfileController, ClubeProfileState>(
      builder: (context, state) {
        return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: VsScrollbar(
            controller: _scrollController,
            showTrackOnHover: true, // default false
            isAlwaysShown: true, // default false
            scrollbarFadeDuration: const Duration(
                milliseconds: 200), // default : Duration(milliseconds: 300)
            scrollbarTimeToFade: const Duration(
                milliseconds: 300), // default : Duration(milliseconds: 600)
            style: const VsScrollbarStyle(
              hoverThickness: 10.0, // default 12.0
              radius: Radius.circular(10), // default Radius.circular(8.0)
              thickness: 10.0, // [ default 8.0 ]
              color: ThemeColors.yellowPadrao, // default ColorScheme Theme
            ),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.listaHinos.length,
              itemBuilder: (context, index) {
                HinosModel hino = widget.listaHinos[index];
                NotasModel? userRate;
                var isUserRate = globals.prefs.getString(hino.uidHino!);
                if (isUserRate != null) {
                  userRate = NotasModel.fromMap(jsonDecode(isUserRate));
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Card(
                      color: ThemeColors
                          .backgroundPlayer, //ThemeColors.backgroundPlayer,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          ListTile(
                              leading: const Icon(
                                Icons.music_note,
                                color: Colors.white,
                                size: 36,
                              ),
                              title: AutoSizeText(
                                hino.nome!,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              subtitle: AutoSizeText.rich(
                                  maxLines: 1,
                                  minFontSize: 1,
                                  TextSpan(children: [
                                    TextSpan(
                                        text: hino.autor != ''
                                            ? hino.autor
                                            : 'Autor Desconhecido',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    TextSpan(
                                        text: hino.ano != '' ? ' | ' : '',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    TextSpan(
                                        text: hino.ano != '' ? hino.ano : '',
                                        style: const TextStyle(
                                            color: Colors.white))
                                  ])),
                              trailing: (state.status.name == 'loadingRate')
                                  ? Transform.scale(
                                      scale: 0.5,
                                      child: const CircularProgressIndicator())
                                  : Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: TextButton.icon(
                                          style: const ButtonStyle(),
                                          onPressed: () {},
                                          icon: Icon(
                                            FontAwesomeIcons.solidHeart,
                                            color: (hino.notaMedia == null ||
                                                    hino.notaMedia == 0)
                                                ? Colors.grey
                                                : ThemeColors.yellowPadrao,
                                            size: 18,
                                          ),
                                          label: AutoSizeText.rich(
                                            (hino.notaMedia == null ||
                                                    hino.notaMedia == 0 ||
                                                    hino.notaMedia!.isNaN)
                                                ? const TextSpan(text: 'S/A')
                                                : TextSpan(children: [
                                                    TextSpan(
                                                        text: DoubleNoRound
                                                            .getNumber(hino
                                                                .notaMedia!)),
                                                    // const TextSpan(
                                                    //     text: '(24)',
                                                    //     style:
                                                    //         TextStyle(fontSize: 11))
                                                  ]),
                                            minFontSize: 1,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          )),
                                    )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  isUserRate == null
                                      ? 'Avalie este hino'
                                      : 'Minha avaliação',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, right: 20),
                                child: RatingBar(
                                  initialRating:
                                      isUserRate == null ? 0 : userRate!.nota!,
                                  itemSize: 17,
                                  maxRating: 5.0,
                                  itemCount: 5,
                                  wrapAlignment: WrapAlignment.end,
                                  minRating: 0.5,
                                  glow: true,
                                  //textDirection: TextDirection.rtl,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  ratingWidget: RatingWidget(
                                    full: image('assets/icons/heart.png'),
                                    half: image('assets/icons/heart_half.png'),
                                    empty:
                                        image('assets/icons/heart_border.png'),
                                  ),
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  onRatingUpdate: (rating) async {
                                    isUserRate == null
                                        ? widget.controller.saveRate(
                                            hino: hino,
                                            time: widget.time,
                                            uidTime: widget.time.uidTime!,
                                            uidHino: hino.uidHino!,
                                            nota: rating)
                                        : widget.controller.updateRate(
                                            hino: hino,
                                            time: widget.time,
                                            uidTime: widget.time.uidTime!,
                                            uidHino: hino.uidHino!,
                                            uidNota: userRate!.uidNota!,
                                            nota: rating);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                            indent: 15,
                            endIndent: 15,
                            height: 5,
                          ),
                          AudioPlayer(
                            audioPlayerController:
                                VideoPlayerController.network(
                                    '${globals.baseUrl}${hino.url}'),
                            looping: true,
                            autoplay: false,
                            hino: hino,
                            time: widget.time,
                            controller: widget.controller,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
