import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataFoundWidget extends StatefulWidget {
  const NoDataFoundWidget({super.key});

  @override
  State<NoDataFoundWidget> createState() => _NoDataFoundWidgetState();
}

class _NoDataFoundWidgetState extends State<NoDataFoundWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        // height: MediaQuery.of(context).size.height * 0.5,
        child: SvgPicture.asset('assets/images/svg/no_data_found.svg'));
  }
}
