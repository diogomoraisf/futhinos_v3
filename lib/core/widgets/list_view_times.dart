import 'package:flutter/material.dart';
import 'package:futhinos_v2/core/widgets/add_admob_native.dart';
import 'package:futhinos_v2/core/widgets/info_message.dart';
import 'package:futhinos_v2/core/widgets/list_tile_time.dart';
import 'package:futhinos_v2/models/times_model.dart';

class ListViewTimes extends StatefulWidget {
  final List<TimesModel> listaTimes;
  final String filterType;
  final String filterUF;
  const ListViewTimes({
    super.key,
    required this.listaTimes,
    required this.filterType,
    required this.filterUF,
  });

  @override
  State<ListViewTimes> createState() => _ListViewTimesState();
}

class _ListViewTimesState extends State<ListViewTimes> {
  @override
  Widget build(BuildContext context) {
    return (widget.listaTimes.isNotEmpty)
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.listaTimes.length,
            itemBuilder: (context, index) {
              final time = widget.listaTimes[index];
              if (time.tipo == widget.filterType) {
                if (widget.filterUF == 'all' || widget.filterUF == time.uf) {
                  return ListTileTime(
                    time: time,
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            },
          )
        : const InfoMessage(message: 'Bola Fora...\n Nenhum time encontrado.');
  }
}
