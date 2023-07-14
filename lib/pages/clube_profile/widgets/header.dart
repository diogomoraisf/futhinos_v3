import 'package:flutter/material.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/services/globals.dart' as globals;

class Header extends StatelessWidget {
  final TimesModel time;
  const Header({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.3,
              image: AssetImage('assets/images/default_bg.jpg'),
              fit: BoxFit.cover)),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SafeArea(
              bottom: false,
              left: false,
              right: false,
              child: Padding(
                padding: const EdgeInsets.only(right: 0, left: 0),
                child: Column(
                  children: [
                    Hero(
                      tag: time.uidTime!,
                      child: Image.network(
                        '${globals.baseUrl}${time.escudoURL!}',
                        height: 140,
                        fit: BoxFit.fitHeight,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.yellow.shade600,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        time.nomeTime!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '${time.cidade} | ${time.uf}',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
