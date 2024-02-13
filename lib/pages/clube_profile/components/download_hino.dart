import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futhinos_v2/models/hinos_model.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/pages/clube_profile/clube_profile_controller.dart';
import 'package:futhinos_v2/pages/clube_profile/clube_profile_state.dart';
import 'package:futhinos_v2/services/globals.dart' as globals;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DownloadHino extends StatefulWidget {
  final HinosModel hino;
  final TimesModel time;
  const DownloadHino({super.key, required this.hino, required this.time});

  @override
  State<DownloadHino> createState() => _DownloadHinoState();
}

class _DownloadHinoState extends State<DownloadHino> {
  //final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    // IsolateNameServer.registerPortWithName(
    //     _port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   int id = data[0];
    //   String status = data[1];
    //   int progress = data[2];
    // });

    // FlutterDownloader.registerCallback(downloadCallback);
  }

  // static void downloadCallback(String status, int id, int progress) {
  //   final SendPort send =
  //       IsolateNameServer.lookupPortByName('downloader_send_port')!;
  //   send.send([id, status, progress]);
  // }

  @override
  void dispose() {
    //IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClubeProfileController, ClubeProfileState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () {},
          downloaded: () => Navigator.of(context).pop(),
        );
      },
      builder: (context, state) {
        ClubeProfileController controller =
            context.read<ClubeProfileController>();
        return BlocBuilder<ClubeProfileController, ClubeProfileState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(
                'Baixar o hino ${widget.time.nomeTime} - ${widget.hino.nome}',
                style: const TextStyle(color: Colors.black),
              ),
              content: RichText(
                  text: TextSpan(
                children: [
                  const TextSpan(
                      text: 'Assista um vídeo curto para liberar o download.\n',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: 'você tem: ${state.downloadCredits} créditos',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ))
                ],
              )),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.black),
                    )),
                TextButton(
                    onPressed: state.rewardedAd != null
                        ? () {
                            state.rewardedAd!.fullScreenContentCallback =
                                FullScreenContentCallback(
                                    onAdShowedFullScreenContent:
                                        (RewardedAd ad) {},
                                    onAdDismissedFullScreenContent:
                                        (RewardedAd ad) {
                                      ad.dispose();
                                      controller.loadRewardedAd();
                                    },
                                    onAdFailedToShowFullScreenContent:
                                        (RewardedAd ad, AdError error) {
                                      ad.dispose();
                                      controller.loadRewardedAd();
                                    });

                            state.rewardedAd!.setImmersiveMode(true);
                            state.rewardedAd!.show(onUserEarnedReward:
                                (AdWithoutView ad, RewardItem reward) {
                              controller
                                  .addDownloadsCredits(reward.amount.toInt());
                            });
                          }
                        : null,
                    child: Text(
                      'Assistir vídeo',
                      style: TextStyle(
                          color: state.rewardedAd != null
                              ? Colors.black
                              : Colors.grey),
                    )),
                TextButton(
                    onPressed: state.downloadCredits >= 10
                        ? () => controller.downloadHino(
                            globals.baseUrl +
                                widget.hino.url! +
                                globals.baseUrlDownload,
                            '${widget.time.nomeTime} - ${widget.hino.nome!}.mp3')
                        : null,
                    child: const Text(
                      'Download',
                      //style: TextStyle(color: Colors.black),
                    )),
              ],
            );
          },
        );
      },
    );
  }
}
