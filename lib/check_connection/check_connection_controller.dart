import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:equatable/equatable.dart';
part 'check_connection_state.dart';

class CheckConnectionController extends Cubit<CheckConnectionState> {
  CheckConnectionController() : super(CheckConnectionState(isConnected: true)) {
    final checkInternetInstance = InternetConnectionCheckerPlus.createInstance(
        checkTimeout: const Duration(seconds: 6),
        checkInterval: const Duration(seconds: 3));
    checkInternetInstance.onStatusChange
        .listen((InternetConnectionStatus status) {
      if (kDebugMode) {
        print('status é: $status');
      }
      switch (status) {
        case InternetConnectionStatus.connected:
          if (state.isConnected == false) {
            emit(state.copyWith(isConnected: true));
          }
          break;
        case InternetConnectionStatus.disconnected:
          if (state.isConnected == true) {
            emit(state.copyWith(isConnected: false));
          }

          break;
      }
    });
  }
}
