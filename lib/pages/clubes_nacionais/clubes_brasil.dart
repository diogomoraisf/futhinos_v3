import 'package:flutter/material.dart';
import 'package:futhinos_v2/core/widgets/add_admob_banner.dart';
import 'package:futhinos_v2/core/widgets/float_buttom_filter.dart';
import 'package:futhinos_v2/core/widgets/list_view_times.dart';
import 'package:futhinos_v2/models/times_model.dart';

class ClubesBrasil extends StatelessWidget {
  final List<TimesModel> listaTimes;
  final String filterUF;
  const ClubesBrasil({
    super.key,
    required this.listaTimes,
    required this.filterUF,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListViewTimes(
              listaTimes: listaTimes,
              filterType: 'brasil',
              filterUF: filterUF,
            ),
          ),
          const AddAdmobBanner(page: 'brasil', isTest: false)
        ],
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: FloatButtomFilter(filterType: 'brasil'),
      ),
    );
  }
}
