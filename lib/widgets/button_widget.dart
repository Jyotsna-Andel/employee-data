import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String? label;
  final Color? color;
  final Color? labelColor;
  final void Function()? onPressed;
  const ButtonWidget(
      {super.key,
      required this.label,
      required this.color,
      required this.labelColor,
      required this.onPressed});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        width: 80,
        child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: widget.color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            child: Text(widget.label!,
                style: TextStyle(color: widget.labelColor))));
  }
}
