import 'package:flutter/material.dart';
import 'package:futhinos_v2/pages/clube_profile/clube_profile_controller.dart';
import 'package:futhinos_v2/pages/clube_profile/clube_profile_page.dart';
import 'package:futhinos_v2/repositories/download_hino/download_hino_repository.dart';
import 'package:futhinos_v2/repositories/download_hino/download_hino_repository_impl.dart';
import 'package:futhinos_v2/repositories/get_hinos/get_hinos_repository.dart';
import 'package:futhinos_v2/repositories/get_hinos/get_hinos_repository_impl.dart';
import 'package:futhinos_v2/repositories/rated_hino/rated_repository.dart';
import 'package:futhinos_v2/repositories/rated_hino/rated_repository_impl.dart';
import 'package:provider/provider.dart';

abstract class ClubeProfileRouter {
  ClubeProfileRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<GetHinosRepository>(
            create: (context) => GetHinosRepositoryImpl(),
          ),
          Provider<DownloadHinoRepository>(
            create: (context) => DownloadHinoRepositoryImpl(),
          ),
          Provider<RatedRepository>(
            create: (context) => RatedRepositoryImpl(),
          ),
          Provider(
            create: (context) => ClubeProfileController(
                context.read(), context.read(), context.read()),
          )
        ],
        builder: (context, child) {
          var args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ClubeProfilePage(time: args['time']);
        },
      );
}
