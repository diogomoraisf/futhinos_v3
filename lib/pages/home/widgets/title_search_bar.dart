import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futhinos_v2/pages/home/home_controller.dart';
import 'package:futhinos_v2/pages/home/home_state.dart';

class TitleSearchBar extends StatefulWidget {
  const TitleSearchBar({super.key});

  @override
  State<TitleSearchBar> createState() => _TitleSearchBarState();
}

class _TitleSearchBarState extends State<TitleSearchBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeController, HomeState>(
      builder: (context, state) {
        HomeController controller = context.read<HomeController>();
        return ListTile(
          leading: const Icon(
            Icons.search,
            color: Colors.white,
            size: 25,
          ),
          title: TextField(
            onChanged: (value) => controller.runFilter(state.listaTimes, value),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black,
              hintText: 'busque o time',
              hintStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
