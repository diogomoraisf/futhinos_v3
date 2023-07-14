import 'package:flutter/material.dart';
import 'package:futhinos_v2/check_connection/check_connection_controller.dart';
import 'package:futhinos_v2/repositories/auth/auth_repository.dart';
import 'package:futhinos_v2/repositories/auth/auth_repository_impl.dart';
import 'package:provider/provider.dart';

class ProviderBindings extends StatelessWidget {
  final Widget child;
  const ProviderBindings({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(),
        ),
        Provider(
          create: (context) => CheckConnectionController(),
        )
      ],
      child: child,
    );
  }
}
