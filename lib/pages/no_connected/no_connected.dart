import 'dart:async';

import 'package:flutter/material.dart';
import 'package:futhinos_v2/core/styles/theme_colors.dart';
import 'package:futhinos_v2/core/widgets/app_bar_main.dart';
import 'package:futhinos_v2/core/widgets/info_message.dart';

class NoConnected extends StatefulWidget {
  const NoConnected({super.key});

  @override
  State<NoConnected> createState() => _NoConnectedState();
}

class _NoConnectedState extends State<NoConnected> {
  bool isLoading = true;

  void startTimer() {
    Timer(const Duration(seconds: 6), () {
      setState(() {
        isLoading = false; //set loading to false
      }); //stops the timer
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLoading ? Colors.white : ThemeColors.backgroundPlayer,
      appBar: const AppBarGeral(
        title: Text('FutHinos'),
        hideBackButton: true,
      ),
      body: Center(
        child: isLoading
            ? const InfoMessage(message: 'ligando os refletores..')
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/no_connected.png'),
                    width: 80,
                    height: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Opsss.. chama o VAR!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 50, left: 50),
                    child: Text(
                      'O FutHinos precisa de uma conexão com a internet para continuar. Verifique a sua conexão pra bola voltar a rolar.',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
