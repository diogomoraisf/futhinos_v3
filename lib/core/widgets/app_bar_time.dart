import 'package:flutter/material.dart';

class AppBarTime extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool backButton;
  final bool transparent;
  final bool reverseTextcolor;
  final bool noShadow;
  final Color bgColor;

  const AppBarTime({
    super.key,
    this.title = "Home",
    this.transparent = false,
    this.reverseTextcolor = false,
    this.backButton = false,
    this.noShadow = false,
    this.bgColor = Colors.white,
  });

  final double _prefferedHeight = 180.0;

  @override
  _AppBarTimeState createState() => _AppBarTimeState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _AppBarTimeState extends State<AppBarTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 102.0,
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
                      ? const Color.fromRGBO(136, 152, 170, 1.0)
                      : Colors.transparent,
                  spreadRadius: -10,
                  blurRadius: 12,
                  offset: const Offset(0, 5))
            ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                                !widget.backButton
                                    ? Icons.menu
                                    : Icons.arrow_back_ios,
                                color: !widget.transparent
                                    ? (widget.bgColor == Colors.white
                                        ? const Color.fromRGBO(44, 44, 44, 1.0)
                                        : Colors.white)
                                    : (widget.reverseTextcolor
                                        ? const Color.fromRGBO(44, 44, 44, 1.0)
                                        : Colors.white),
                                size: 24.0),
                            onPressed: () {
                              if (!widget.backButton) {
                                Scaffold.of(context).openDrawer();
                              } else {
                                Navigator.pop(context);
                              }
                            }),
                        Text(widget.title,
                            style: TextStyle(
                                color: !widget.transparent
                                    ? (widget.bgColor == Colors.white
                                        ? const Color.fromRGBO(44, 44, 44, 1.0)
                                        : Colors.white)
                                    : (widget.reverseTextcolor
                                        ? const Color.fromRGBO(44, 44, 44, 1.0)
                                        : Colors.white),
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
