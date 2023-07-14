// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppBarGeral extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final double? elevation;
  final Color? backgroundColor;
  final List<Widget>? menuItens;
  final bool hideBackButton;
  final IconData? icon;
  final Function()? destino;
  final Widget? title;
  final PreferredSizeWidget? bottom;
  const AppBarGeral(
      {Key? key,
      this.height = kToolbarHeight,
      this.backgroundColor = Colors.black,
      this.menuItens,
      this.elevation = 0,
      this.hideBackButton = false,
      this.icon,
      this.destino,
      this.title,
      this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: elevation,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: true,
        actions: menuItens,
        toolbarHeight: preferredSize.height,
        title: title,
        centerTitle: true,
        bottom: bottom,
        leading: hideBackButton
            ? null
            : icon == null
                ? const BackButton(
                    color: Colors.white,
                  )
                : IconButton(
                    onPressed: destino!(),
                    icon: Icon(
                      icon,
                      size: 25,
                      color: Colors.black,
                    )));
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
