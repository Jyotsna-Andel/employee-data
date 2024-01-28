import 'package:MyEmployee/services/globals.dart';
import 'package:MyEmployee/services/theme.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatefulWidget {
  final int? iconCode;
  const IconWidget({super.key, required this.iconCode});

  @override
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(
            IconData(widget.iconCode!,
                fontFamily: 'MyEmployeeApp', fontPackage: Globals.kFontPkg),
            color: AppTheme.kIconColor,
            size: Globals.deviceType == "phone" ? 25 : 22));
  }
}
