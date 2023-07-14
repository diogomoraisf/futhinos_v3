import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futhinos_v2/check_connection/check_connection.dart';
import 'package:futhinos_v2/check_connection/check_connection_controller.dart';
import 'package:futhinos_v2/core/provider/provider_bindings.dart';
import 'package:futhinos_v2/pages/clube_profile/clube_profile_router.dart';
import 'package:futhinos_v2/pages/clube_ranking/clube_ranking_router.dart';
import 'package:futhinos_v2/pages/details/details_router.dart';
import 'package:futhinos_v2/pages/letra_hino.dart/letra_hino_router.dart';

class FutHinos extends StatelessWidget {
  const FutHinos({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderBindings(
      child: MaterialApp(
        title: 'FutHinos',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        color: Colors.transparent,
        routes: {
          '/': (context) => BlocProvider(
                lazy: false,
                create: (_) => CheckConnectionController(),
                child: const CheckConnection(),
              ),
          'clubeProfile': (context) => ClubeProfileRouter.page,
          'letraHino': (context) => LetraHinoRouter.page,
          'details': (context) => DetailsRouter.page,
          'ranking': (context) => ClubeRankingRouter.page
        },
      ),
    );
  }
}
