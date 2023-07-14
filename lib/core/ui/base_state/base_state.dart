import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:futhinos_v2/core/helpers/messages.dart';
import 'package:provider/provider.dart';

import '../../helpers/loader.dart';

abstract class BaseState<T extends StatefulWidget, C extends BlocBase>
    extends State<T> with Loader, Messages {
  late final C controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<C>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
  }

  void onReady() {}
}
