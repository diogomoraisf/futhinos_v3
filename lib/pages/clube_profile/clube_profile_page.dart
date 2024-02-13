import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futhinos_v2/core/ui/base_state/base_state.dart';
import 'package:futhinos_v2/core/widgets/add_admob_banner.dart';
import 'package:futhinos_v2/core/widgets/app_bar_time.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/pages/clube_profile/clube_profile_controller.dart';
import 'package:futhinos_v2/pages/clube_profile/clube_profile_state.dart';
import 'package:futhinos_v2/pages/clube_profile/widgets/card_player.dart';
import 'package:futhinos_v2/pages/clube_profile/widgets/header.dart';
import 'package:futhinos_v2/pages/clube_profile/widgets/letra_hino_buttom.dart';
import 'package:futhinos_v2/pages/clube_profile/widgets/social_media_bar.dart';

class ClubeProfilePage extends StatefulWidget {
  final TimesModel time;
  const ClubeProfilePage({super.key, required this.time});

  @override
  State<ClubeProfilePage> createState() => _ClubeProfilePageState();
}

class _ClubeProfilePageState
    extends BaseState<ClubeProfilePage, ClubeProfileController> {
  @override
  void initState() {
    super.initState();
    controller.getHinos(widget.time.uidTime!);
    controller.loadRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarTime(
        title: 'Hino | ${widget.time.nomeTime!}',
        backButton: true,
        transparent: true,
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Flexible(
                  flex: 1,
                  child: Header(
                    time: widget.time,
                  )),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: Column(
                      children: [
                        LetraHinoButtom(
                          time: widget.time,
                        ),
                        BlocConsumer<ClubeProfileController, ClubeProfileState>(
                          listener: (context, state) {
                            state.status.matchAny(
                              any: () => hideLoader(),
                              loading: () => showLoader(),
                              loadingRingtone: () => showLoader(),
                              prepareDownload: () =>
                                  showLoader(message: 'Preparando tudo..'),
                              loadedRewarsAdFail: () =>
                                  controller.loadRewardedAd(),
                              loadedRingtone: () {
                                hideLoader();
                                showInfo(
                                    'Hino definido como toque padrão do seu smartphone com sucesso!');
                              },
                              downloading: () {
                                hideLoader();
                                showLoader(
                                    message: 'Download iniciado.. aguarde');
                              },
                              downloaded: () {
                                hideLoader();
                                showInfo(
                                    'Download concluído.. veja os detalhes na notificação ou acesse sua pasta de Downloads.');
                              },
                              error: () {
                                hideLoader();
                                showError(state.errorMessage ??
                                    'Erro inesperado. Tente novamente mais tarde');
                              },
                            );
                          },
                          builder: (context, state) {
                            if (state.listaHinos.isNotEmpty) {
                              return Expanded(
                                child: CustomScrollView(
                                  slivers: [
                                    SliverToBoxAdapter(
                                      //scrollDirection: Axis.vertical,
                                      child: SizedBox(
                                        height: 180,
                                        child: CardPlayer(
                                          listaHinos: state.listaHinos,
                                          time: widget.time,
                                          controller: controller,
                                        ),
                                      ),
                                    ),
                                    SliverFillRemaining(
                                      hasScrollBody: false,
                                      child: MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        removeLeft: true,
                                        removeRight: true,
                                        removeBottom: true,
                                        child: const Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: AddAdmobBanner(
                                              page: 'clube', isTest: false),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        )
                      ],
                    ),
                  ))
            ],
          ),
          SocialMediaBar(time: widget.time),
        ],
      ),
    );
  }
}
