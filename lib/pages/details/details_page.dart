import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';
import 'package:futhinos_v2/core/ui/base_state/base_state.dart';
import 'package:futhinos_v2/pages/details/details_controller.dart';
import 'package:futhinos_v2/pages/details/details_state.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends BaseState<DetailsPage, DetailsController> {
  @override
  void initState() {
    super.initState();
    controller.checkVersion();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsController, DetailsState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          openingEmail: () => showLoader(),
          openingReview: () => showLoader(),
          openedShare: () => showLoader(),
          error: () {
            hideLoader();
            showError(state.errorMessage ??
                'Oops.. ocorreu um erro inesperado. Tente novamente mais tarde.');
          },
        );
      },
      builder: (context, state) {
        return ListView(
            children: ListTile.divideTiles(
          context: context,
          tiles: [
            InkWell(
              onTap: () {
                controller.openMailto('dmej.mobile@gmail.com',
                    'FutHinos - Meu Feedback sobre o aplicativo');
              },
              child: const ListTile(
                title: Text('Queremos ouvir você'),
                subtitle: Text('Encontrou algum erro? Alguma Sugestão?'),
              ),
            ),
            InkWell(
              onTap: () {
                controller.openLink(
                    'https://docs.google.com/forms/d/e/1FAIpQLSdvGBP99pFQeZ6q0caum7XlOg3PkL2ubk-qJmloXYS32gZsDg/viewform?usp=sf_link');
              },
              child: const ListTile(
                title: Text('Envie o hino do seu time'),
                subtitle: Text('Sentiu falta de um hino? Nos envie aqui'),
              ),
            ),
            InkWell(
              onTap: () {
                controller.openReview();
              },
              child: const ListTile(
                title: Text('Avalie o Aplicativo'),
                subtitle: Text('5 estrelas seria pedir muito?'),
              ),
            ),
            InkWell(
              onTap: () {
                controller.shareApp(
                    'Ouça os hinos dos clubes brasileiros e internacionais: bit.ly/fut_hinos',
                    'FutHino - Hinos do clubes de Futebol');
              },
              child: ListTile(
                title: const Text('Compartilhe'),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        size: 20,
                        FontAwesomeIcons.whatsapp,
                        color: Color.fromARGB(255, 33, 134, 36),
                      ),
                      const Icon(
                        size: 20,
                        FontAwesomeIcons.facebook,
                        color: ThemeColors.facebook,
                      ),
                      const Icon(
                        size: 20,
                        FontAwesomeIcons.instagram,
                        color: ThemeColors.instagram,
                      ),
                      const Icon(
                        size: 20,
                        FontAwesomeIcons.twitter,
                        color: ThemeColors.twitter,
                      ),
                      const Icon(
                        size: 20,
                        Icons.chat_outlined,
                        color: Colors.red,
                      ),
                      Icon(
                        size: 20,
                        Icons.email_outlined,
                        color: Colors.yellow.shade700,
                      ),
                      const Icon(
                        size: 20,
                        Icons.menu,
                        color: ThemeColors.blackPadrao,
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                  title: const Text('Versão do Aplicativo'),
                  isThreeLine: false,
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.versionStatus != null
                          ? RichText(
                              text: TextSpan(
                                  style: const TextStyle(color: Colors.black54),
                                  children: [
                                  TextSpan(
                                      text: state.versionStatus!.localVersion),
                                  const TextSpan(text: ' - '),
                                  TextSpan(
                                      text: (state.versionStatus!.canUpdate &&
                                              state.versionStatus != null)
                                          ? 'Nova versão encontrada.'
                                          : 'Sua versão está atualizada.')
                                ]))
                          : const Text('buscando..'),
                      state.versionStatus != null
                          ? state.versionStatus!.canUpdate
                              ? TextButton.icon(
                                  style: TextButton.styleFrom(
                                      minimumSize: const Size(50, 20),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      padding: EdgeInsets.zero),
                                  onPressed: () {
                                    controller.updateVersion(
                                        state.versionStatus!,
                                        context,
                                        'Nova Versão Disponível',
                                        'Atualizar o FutHinos para versão mais recente',
                                        'Atualizar',
                                        'Talvez Depois',
                                        () {});
                                  },
                                  icon: const Icon(
                                    Icons.update,
                                    size: 15,
                                  ),
                                  label: const Text('Atualizar'))
                              : Container()
                          : Container()
                    ],
                  )),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text('Desenvolvido por'),
                subtitle: Text('dm&J mobile'),
              ),
            ),
          ],
        ).toList());
      },
    );
  }
}
