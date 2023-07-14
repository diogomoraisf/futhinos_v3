import 'package:flutter/material.dart';
import 'package:futhinos_v2/pages/clube_ranking/clube_ranking_controller.dart';
import 'package:futhinos_v2/pages/clube_ranking/clube_ranking_page.dart';
import 'package:futhinos_v2/repositories/get_hinos/get_hinos_repository.dart';
import 'package:futhinos_v2/repositories/get_hinos/get_hinos_repository_impl.dart';
import 'package:futhinos_v2/repositories/get_times/get_times_repository.dart';
import 'package:futhinos_v2/repositories/get_times/get_times_repository_impl.dart';
import 'package:futhinos_v2/repositories/rated_hino/rated_repository.dart';
import 'package:futhinos_v2/repositories/rated_hino/rated_repository_impl.dart';
import 'package:provider/provider.dart';

class ClubeRankingRouter {
  ClubeRankingRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<GetTimesRepository>(
            create: (context) => GetTimesRepositoryImpl(),
          ),
          Provider<RatedRepository>(
            create: (context) => RatedRepositoryImpl(),
          ),
          Provider(
              create: (context) =>
                  ClubeRankingController(context.read(), context.read()))
        ],
        child: const ClubeRankingPage(),
      );
}
