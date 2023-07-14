import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';
import 'package:futhinos_v2/core/ui/base_state/base_state.dart';
import 'package:futhinos_v2/core/widgets/add_admob_banner.dart';
import 'package:futhinos_v2/core/widgets/app_bar_main.dart';
import 'package:futhinos_v2/core/widgets/info_message.dart';
import 'package:futhinos_v2/models/ranking_model.dart';
import 'package:futhinos_v2/pages/clube_ranking/clube_ranking_controller.dart';
import 'package:futhinos_v2/pages/clube_ranking/clube_ranking_state.dart';
import 'package:futhinos_v2/pages/clube_ranking/components/color_ranking.dart';
import 'package:futhinos_v2/core/helpers/double_no_round.dart';
import 'package:futhinos_v2/services/globals.dart';

class ClubeRankingPage extends StatefulWidget {
  const ClubeRankingPage({
    super.key,
  });

  @override
  State<ClubeRankingPage> createState() => _ClubeRankingPageState();
}

class _ClubeRankingPageState
    extends BaseState<ClubeRankingPage, ClubeRankingController> {
  @override
  void initState() {
    super.initState();
    controller.getAllHinos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClubeRankingController, ClubeRankingState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          gettingTime: () => showLoader(),
          gettedTime: () {
            hideLoader();
            Navigator.of(context)
                .pushNamed('clubeProfile', arguments: {'time': state.time});
          },
          error: () {
            hideLoader();
            showError(state.errorMessage ??
                'Erro inesperado. Tente novamente mais tarde.');
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: const AppBarGeral(
              title: Text('Ranking | FutHinos'),
              hideBackButton: true,
            ),
            body: state.listaRanking.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          //physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: state.listaRanking.length,
                          itemBuilder: (context, index) {
                            RankingModel time = state.listaRanking[index];
                            return ListTile(
                              tileColor: index + 1 == 1
                                  ? ThemeColors.backgroundPlayer
                                  : null,
                              onTap: () async {
                                await controller.getTimeById(time.uidTime!);
                              },
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: CircleAvatar(
                                        radius: index + 1 == 1 ? 20 : null,
                                        foregroundColor:
                                            ColorRanking.getForegroundColor(
                                                index + 1),
                                        backgroundColor:
                                            ColorRanking.getBackgroundColor(
                                                index + 1),
                                        child: AutoSizeText(
                                          '${index + 1}º',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  Image(
                                      height: 35,
                                      width: 35,
                                      image: NetworkImage(
                                          baseUrl + time.escudoURL!))
                                ],
                              ),
                              title: AutoSizeText(
                                time.nomeTime!,
                                style: TextStyle(
                                    color: index + 1 == 1
                                        ? ThemeColors.yellowPadrao
                                        : Colors.black),
                              ),
                              subtitle: AutoSizeText(
                                time.nome!,
                                style: TextStyle(
                                    color: index + 1 == 1
                                        ? ThemeColors.yellowPadrao
                                        : Colors.black45),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  index + 1 == 1
                                      ? const Padding(
                                          padding: EdgeInsets.only(right: 15.0),
                                          child: Icon(
                                            FontAwesomeIcons.medal,
                                            color: ThemeColors.yellowPadrao,
                                            size: 30,
                                          ),
                                        )
                                      : Container(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                right: 5, left: 0),
                                            child: Icon(
                                              FontAwesomeIcons.solidHeart,
                                              color: ThemeColors.yellowPadrao,
                                              size: 20,
                                            ),
                                          ),
                                          AutoSizeText(
                                            DoubleNoRound.getNumber(
                                                time.notaMedia!),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: index + 1 == 1
                                                  ? ThemeColors.yellowPadrao
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: AutoSizeText(
                                          '(${time.qtdaNotas})',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: index + 1 == 1
                                                  ? ThemeColors.yellowPadrao
                                                  : Colors.black87),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const AddAdmobBanner(page: 'ranking', isTest: false),
                    ],
                  )
                : const Center(
                    child: InfoMessage(
                      message: 'VAR revisando o ranking..',
                    ),
                  ));
      },
    );
  }
}
