import 'package:flutter/material.dart';
import 'package:futhinos_v2/pages/home/home_controller.dart';
import 'package:futhinos_v2/pages/home/home_page.dart';
import 'package:futhinos_v2/repositories/get_times/get_times_repository.dart';
import 'package:futhinos_v2/repositories/get_times/get_times_repository_impl.dart';
import 'package:provider/provider.dart';

abstract class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<GetTimesRepository>(
            create: (context) => GetTimesRepositoryImpl(),
          ),
          Provider(
            create: (context) => HomeController(context.read()),
          )
        ],
        child: const HomePage(),
      );
}
