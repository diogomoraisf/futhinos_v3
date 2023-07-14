import 'package:flutter/material.dart';
import 'package:futhinos_v2/pages/letra_hino.dart/letra_hino_controller.dart';
import 'package:futhinos_v2/pages/letra_hino.dart/letra_hino_page.dart';
import 'package:futhinos_v2/repositories/get_hinos/get_hinos_repository.dart';
import 'package:futhinos_v2/repositories/get_hinos/get_hinos_repository_impl.dart';
import 'package:provider/provider.dart';

abstract class LetraHinoRouter {
  LetraHinoRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<GetHinosRepository>(
            create: (context) => GetHinosRepositoryImpl(),
          ),
          Provider(
            create: (context) => LetraHinoController(context.read()),
          )
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return LetraHinoPage(time: args['time']);
        },
      );
}
