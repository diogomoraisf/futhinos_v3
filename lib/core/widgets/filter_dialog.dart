import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futhinos_v2/models/times_model.dart';
import 'package:futhinos_v2/pages/home/home_controller.dart';

class FilterDialog {
  static List<String>? selectedFilterList = [];

  static Future<void> openFilterDialog(
      {required BuildContext context,
      required List<TimesModel> listaTimes,
      required String filterType,
      required String selectedFilter,
      required List<String> choices}) async {
    HomeController controller = context.read<HomeController>();
    if (selectedFilter != 'all') {
      selectedFilterList = (selectedFilter.split(','));
    } else {
      selectedFilterList = [];
    }
    await FilterListDialog.display<String>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(context),
      headlineText:
          filterType == 'brasil' ? 'Filtrar pelo Estado' : 'Filtrar por País',
      hideCloseIcon: true,
      height: MediaQuery.of(context).size.height * 0.6,
      listData: choices,
      selectedListData: selectedFilterList,
      choiceChipLabel: (item) => item!,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.Reset],
      applyButtonText: 'Aplicar',
      resetButtonText: 'Limpar',
      enableOnlySingleSelection: true,
      barrierDismissible: true,
      onItemSearch: (uf, query) {
        return uf.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (filterKey) {
        if (filterKey != null && filterKey.isNotEmpty) {
          controller.updateFilterUF(filterType, filterKey.first);
        } else {
          controller.updateFilterUF(filterType, 'all');
        }
        Navigator.pop(context);
      },
      choiceChipBuilder: (context, item, isSelected) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: isSelected! ? Colors.yellow[700]! : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? Colors.black38 : Colors.grey[300]!,
              )),
          child: Text(
            item,
            style:
                TextStyle(color: isSelected ? Colors.white : Colors.grey[500]),
          ),
        );
      },
    );
  }
}
