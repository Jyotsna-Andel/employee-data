// ignore: must_be_immutable
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  // final double _kIconSize = Globals.deviceType == "phone" ? 100 : 100.0;
  final double height = 60;
  final String? title;
  final VoidCallback? onTap;

  AppBarWidget({Key? key, this.onTap, required this.title}) : super(key: key);

  // @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 16,
          title: Text(title!, textAlign: TextAlign.left));
    });
  }
}
