import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:futhinos_v2/check_connection/check_connection_controller.dart';
import 'package:futhinos_v2/pages/home/home_router.dart';
import 'package:futhinos_v2/pages/no_connected/no_connected_router.dart';

class CheckConnection extends StatefulWidget {
  const CheckConnection({super.key});

  @override
  State<CheckConnection> createState() => _CheckConnectionState();
}

class _CheckConnectionState extends State<CheckConnection> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CheckConnectionController, CheckConnectionState>(
        builder: (context, state) {
          if (state.isConnected) {
            return HomeRouter.page;
          } else {
            return NoConnectedRouter.page;
          }
        },
      ),
    );
  }
}
