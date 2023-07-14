import 'package:flutter/material.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/services/globals.dart' as globals;
import 'package:badges/badges.dart' as badges;

class ListTileTime extends StatefulWidget {
  final TimesModel time;
  const ListTileTime({super.key, required this.time});

  @override
  State<ListTileTime> createState() => _ListTileTimeState();
}

class _ListTileTimeState extends State<ListTileTime> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed('clubeProfile', arguments: {'time': widget.time}),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Hero(
              tag: widget.time.uidTime!,
              child: Image.network(
                '${globals.baseUrl}${widget.time.escudoURL!}',
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
          ),
          title: Text(
            widget.time.nomeTime!,
          ),
          subtitle: Text(
            '${widget.time.cidade!} | ${widget.time.uf!}',
          ),
          trailing: badges.Badge(
            badgeContent: Text('${widget.time.qtdaHinos}'),
            badgeStyle: badges.BadgeStyle(badgeColor: Colors.yellow.shade700),
            position: badges.BadgePosition.topStart(top: 10),
            child: IconButton(
                onPressed: () => Navigator.of(context).pushNamed('clubeProfile',
                    arguments: {'time': widget.time}),
                padding: const EdgeInsets.only(left: 20),
                icon: const Icon(Icons.arrow_forward_ios_outlined)),
          )),
    );
  }
}
