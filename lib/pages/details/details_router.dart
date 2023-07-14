import 'package:flutter/material.dart';
import 'package:futhinos_v2/pages/details/details_controller.dart';
import 'package:futhinos_v2/pages/details/details_page.dart';
import 'package:futhinos_v2/repositories/details/details_repository.dart';
import 'package:futhinos_v2/repositories/details/details_repository_impl.dart';
import 'package:provider/provider.dart';

abstract class DetailsRouter {
  DetailsRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<DetailsRepository>(
            create: (context) => DetailsRepositoryImpl(),
          ),
          Provider(
            create: (context) => DetailsController(context.read()),
          )
        ],
        child: const DetailsPage(),
      );
}
