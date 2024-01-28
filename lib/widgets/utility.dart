import 'package:MyEmployee/services/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Utility {
  static showAlertDialog(context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text("Delete Employee?",
                    style: AppTheme.appTheme.textTheme.titleMedium),
                content: Text(
                    "Are you sure you want to delete selected employee?",
                    style: AppTheme.appTheme.textTheme.bodySmall!
                        .copyWith(color: Colors.black)),
                actions: [
                  buttonWidget(
                    label: 'No',
                    color: AppTheme.kButtonColorLight,
                    labelColor: AppTheme.kButtonColorDark,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  buttonWidget(
                    label: 'Yes',
                    color: AppTheme.kButtonColorDark,
                    labelColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  )
                ]));
  }

  static buttonWidget(
      {final String? label,
      final Color? color,
      final Color? labelColor,
      final void Function()? onPressed}) {
    return SizedBox(
        height: 40,
        width: 80,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            child: Text(label!, style: TextStyle(color: labelColor))));
  }

  static void showSnackBar(String? msg, context, double height, double margin) {
    try {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
              alignment: Alignment.centerLeft,
              height: height ?? 40,
              child: Text(msg!,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontWeight: FontWeight.w600))),
          backgroundColor: Colors
              .black, //Theme.of(context).colorScheme.primaryVariant.withOpacity(0.8),
          padding: const EdgeInsets.only(left: 16),
          margin: EdgeInsets.only(left: 16, right: 16, bottom: margin),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3)));
    } catch (e) {
      rethrow;
      // print("error");
    }
  }

  static String uuid() {
    // Create a new UUID
    var uuid = const Uuid();
    String newId = uuid.v4();

    return newId;
  }

  static DateTime parseDate(String? dateStr) {
    String pattern = "d MMM yyyy";

    DateFormat format = DateFormat(pattern);
    DateTime parsedDate = format.parse(dateStr!);

    return parsedDate;
  }

  static Future<DateTime?> showDatePicker(context) async {
    DateTime? newDateTime = await showRoundedDatePicker(
      context: context,
      height: MediaQuery.of(context).size.height * 0.35,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      textNegativeButton: 'Cancel',
      textPositiveButton: 'Save',
    );

    return newDateTime;
  }
}
