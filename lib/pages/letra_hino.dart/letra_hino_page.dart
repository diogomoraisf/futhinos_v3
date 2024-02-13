import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';
import 'package:futhinos_v2/core/ui/base_state/base_state.dart';
import 'package:futhinos_v2/core/widgets/add_admob_banner.dart';
import 'package:futhinos_v2/core/widgets/app_bar_time.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:futhinos_v2/pages/letra_hino.dart/letra_hino_controller.dart';
import 'package:futhinos_v2/pages/letra_hino.dart/letra_hino_state.dart';

class LetraHinoPage extends StatefulWidget {
  final TimesModel time;
  const LetraHinoPage({super.key, required this.time});

  @override
  State<LetraHinoPage> createState() => _LetraHinoPageState();
}

class _LetraHinoPageState
    extends BaseState<LetraHinoPage, LetraHinoController> {
  ScrollController scrollControler = ScrollController();
  @override
  void initState() {
    super.initState();
    controller.readLetraHino(widget.time.urlLetra!);
  }

  @override
  void dispose() {
    super.dispose();
    DefaultCacheManager().emptyCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarTime(
          title: 'Letra do Hino | ${widget.time.nomeTime!}',
          backButton: true,
          transparent: true,
        ),
        backgroundColor: Colors.transparent,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.small(
                onPressed: () {
                  scrollControler.animateTo(
                      scrollControler.position.minScrollExtent,
                      duration: const Duration(seconds: 1),
                      curve: Curves.linear);
                },
                heroTag: null,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  scrollControler.animateTo(
                      scrollControler.position.maxScrollExtent,
                      duration: const Duration(seconds: 30),
                      curve: Curves.linear);
                },
                heroTag: null,
                backgroundColor: ThemeColors.yellowPadrao,
                child: const Icon(
                  Icons.arrow_drop_up,
                  size: 40,
                  color: ThemeColors.blackPadrao,
                ),
              )
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/default_bg.jpg',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.2)),
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 100, left: 20, right: 20),
                        child:
                            BlocConsumer<LetraHinoController, LetraHinoState>(
                          listener: (context, state) {
                            state.status.matchAny(
                              any: () => hideLoader(),
                              loading: () => showLoader(),
                              error: () {
                                hideLoader();
                                showError(state.errorMessage ??
                                    'Erro ao buscar esse hino. Tente novamente mais tarde.');
                              },
                            );
                          },
                          builder: (context, state) {
                            return Container(
                              color: Colors.transparent,
                              width: double.infinity,
                              height: double.infinity,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  controller: scrollControler,
                                  child: Column(
                                    children: [
                                      state.letraHino != ''
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 40.0),
                                              child: Text(state.letraHino,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.fade,
                                                      color: Colors.white,
                                                      fontSize: 28)),
                                            )
                                          : const Center(
                                              child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      ThemeColors.yellowPadrao),
                                            )),
                                      MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: const Padding(
                                          padding: EdgeInsets.only(bottom: 1.0),
                                          child: AddAdmobBanner(
                                              isTest: false, page: 'letra'),
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          },
                        ),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
