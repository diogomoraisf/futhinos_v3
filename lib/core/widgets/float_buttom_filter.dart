import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futhinos_v2/core/widgets/filter_dialog.dart';
import 'package:futhinos_v2/pages/home/home_controller.dart';
import 'package:futhinos_v2/pages/home/home_state.dart';

class FloatButtomFilter extends StatefulWidget {
  final String filterType;
  const FloatButtomFilter({super.key, required this.filterType});

  @override
  State<FloatButtomFilter> createState() => _FloatButtomFilterState();
}

class _FloatButtomFilterState extends State<FloatButtomFilter> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeController, HomeState>(
      builder: (context, state) {
        return FloatingActionButton(
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.filter_alt_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              FilterDialog.openFilterDialog(
                  context: context,
                  listaTimes: state.listaTimes,
                  filterType: widget.filterType,
                  selectedFilter: widget.filterType == 'brasil'
                      ? state.filterEstado
                      : state.filterPais,
                  choices: widget.filterType == 'brasil'
                      ? state.choicesBrasilUF
                      : state.choicesMundoUF);
            });
      },
    );
  }
}
