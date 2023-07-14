import 'dart:developer';

import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';
import 'package:futhinos_v2/models/hinos_model.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/pages/clube_profile/clube_profile_controller.dart';
import 'package:futhinos_v2/pages/clube_profile/components/download_hino.dart';
import 'package:futhinos_v2/services/globals.dart';
import 'package:video_player/video_player.dart';

class AudioPlayer extends StatefulWidget {
  final VideoPlayerController audioPlayerController;
  final bool looping;
  final bool autoplay;
  final HinosModel hino;
  final TimesModel time;
  final ClubeProfileController controller;
  const AudioPlayer(
      {super.key,
      required this.controller,
      required this.audioPlayerController,
      required this.looping,
      required this.autoplay,
      required this.hino,
      required this.time});

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  late ChewieAudioController? _chewieAudioController;
  @override
  void initState() {
    _chewieAudioController = ChewieAudioController(
      videoPlayerController: widget.audioPlayerController,
      controlsSafeAreaMinimum: EdgeInsets.zero,
      autoInitialize: true,
      customControls: const CupertinoControls(
          backgroundColor: Colors.black, iconColor: ThemeColors.yellowPadrao),
      allowPlaybackSpeedChanging: false,
      zoomAndPan: false,
      allowMuting: false,
      showControlsOnInitialize: false,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () {
              ClubeProfileController controller =
                  context.read<ClubeProfileController>();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BlocProvider<ClubeProfileController>.value(
                    value: controller,
                    child: DownloadHino(
                      hino: widget.hino,
                      time: widget.time,
                    ),
                  );
                },
              ).then((value) => Navigator.of(context).pop());
            },
            iconData: Icons.download,
            title: 'Baixar Hino',
          ),
          OptionItem(
              onTap: () async {
                await widget.controller.addRingtone(baseUrl + widget.hino.url!);
              },
              iconData: FontAwesomeIcons.music,
              title: 'Definir como toque')
        ];
      },
      optionsTranslation: OptionsTranslation(
        playbackSpeedButtonText: 'Velocidade de Reprodução',
        subtitlesButtonText: 'Legendas',
        cancelButtonText: 'Fechar',
      ),
      errorBuilder: (context, errorMessage) {
        log('erro no player de audio', error: errorMessage);
        return const Center(
          child: Text(
            'Oops.. que bola fora! Um erro ocorreu, reinicie o aplicativo.',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    widget.audioPlayerController.pause();
    _chewieAudioController?.pause();
    widget.audioPlayerController.dispose();
    _chewieAudioController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8, top: 5),
        child: _chewieAudioController != null
            ? ChewieAudio(controller: _chewieAudioController!)
            : const CircularProgressIndicator(),
      ),
    );
  }
}
