import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';
import 'package:futhinos_v2/core/ui/base_state/base_state.dart';
import 'package:futhinos_v2/core/widgets/app_bar_main.dart';
import 'package:futhinos_v2/core/widgets/info_message.dart';
import 'package:futhinos_v2/pages/clubes_internacionais/clubes_mundo.dart';
import 'package:futhinos_v2/pages/clubes_nacionais/clubes_brasil.dart';
import 'package:futhinos_v2/pages/details/details_router.dart';
import 'package:futhinos_v2/pages/home/home_controller.dart';
import 'package:futhinos_v2/pages/home/home_state.dart';
import 'package:futhinos_v2/core/ui/presentation/brazil_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void initState() {
    super.initState();
    // remove splash scren
    //FlutterNativeSplash.remove();
    controller.getTimes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeController, HomeState>(listener: (context, state) {
      state.status.matchAny(
        any: () => hideLoader(),
        loading: () => showLoader(),
        error: () {
          hideLoader();
          showError(state.errorMessage ??
              'Erro inesperado. Tente novamente mais tarde');
        },
      );
    }, builder: (context, state) {
      final List<Widget> pages = [
        ClubesBrasil(
          listaTimes: state.filterTimes,
          filterUF: state.filterEstado,
        ),
        ClubesMundo(
          listaTimes: state.filterTimes,
          filterUF: state.filterPais,
        ),
        DetailsRouter.page
      ];
      return Scaffold(
        appBar: AppBarGeral(
          title: state.titleSearchBar,
          hideBackButton: true,
          menuItens: [
            state.indexSelectedPage == 2
                ? Container()
                : IconButton(
                    onPressed: () {
                      if (state.iconIsSearch) {
                        controller.isSearch(state.iconIsSearch);
                        controller.runFilter(state.listaTimes, '');
                      } else {
                        controller.isSearch(state.iconIsSearch);
                      }
                    },
                    icon: Icon(state.icon)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('ranking');
                },
                icon: const Icon(
                  FontAwesomeIcons.medal,
                  color: ThemeColors.yellowPadrao,
                )),
          ],
        ),
        body: state.status.name != 'loading'
            ? pages[state.indexSelectedPage]
            : const InfoMessage(message: 'escalando os times..'),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: ThemeColors.yellowPadrao,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            currentIndex: state.indexSelectedPage,
            onTap: (index) {
              controller.selectedPage(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Brazil.brazil), label: 'Brasil'),
              BottomNavigationBarItem(icon: Icon(Brazil.globe), label: 'Mundo'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline_rounded), label: 'Sobre')
            ]),
      );
    });
  }
}
