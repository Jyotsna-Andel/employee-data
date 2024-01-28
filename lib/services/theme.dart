import 'package:MyEmployee/services/globals.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static Color kPrimaryColor = Colors.greenAccent;
  static const Color kAccentColor = Color(0xff323238);
  static const Color kOnPrimaryColor = Color(0xff808ED3);
  static const Color kFontColor1 = Colors.black;
  static const Color kCardColor = Color(0xffFFFFFF);
  static const Color kTxtfieldBorderColor = Color(0xffBCC5D4);

  static const Color kTxtFieldColor = Color(0xeff949C9E);
  // static Color kIconColor = Color(0xff535353).withOpacity(0.75);

  //Font-sizes
  static const double kSubtitleFontSize = 16.0;
  // static const double kHeadline1TextFontSize = 22.0;
  // static const double kHeadline2TextFontSize = 16.0;
  // static const double kSubtitle2FontSize = 10.0;
  static const double kTitleMediumFontSize = 10.0;
  static const double kBodyTextMedium = 16.0;
  static const double kBodyTextSmall = 14.0;

  static const double kTitleLargeFontSize = 50.0;
  static const double kCaptionFontSize = 14.0;
  static const double kSize = 8.0;

  //Borders
  static const double kBorderRadius = 0.0;
  static const double kBorderWidth = 0.0;
  static const double kBottomSheetModalUpperRadius = 25.0;

  //Icons color
  static const Color kIconColor = Color(0xff1DA1F2);
  static const Color kButtonColorLight = Color(0xffEDF8FF);
  static const Color kButtonColorDark = Color(0xff1DA1F2);

  static final ThemeData appTheme = ThemeData(
      // canvasColor: Colors.transparent,
      fontFamily: 'Roboto',
      primaryColor: Colors.white,
      // accentColor: kAccentColor,
      errorColor: Colors.red,
      cardTheme: const CardTheme(color: kCardColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kButtonColorDark, foregroundColor: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(
          // headlineMedium: TextStyle(
          //     fontSize: Globals.deviceType == "phone"
          //         ? kHeadline1TextFontSize
          //         : kHeadline1TextFontSize + kSize,
          //     fontFamily: 'Roboto Bold',
          //     fontWeight: FontWeight.normal,
          //     color: kAccentColor),
          // headlineSmall: TextStyle(
          //     fontSize: Globals.deviceType == "phone"
          //         ? kHeadline2TextFontSize
          //         : kHeadline2TextFontSize + kSize,
          //     fontFamily: 'Roboto Bold',
          //     fontWeight: FontWeight.normal,
          //     color: kAccentColor),
          // headlineLarge: TextStyle(
          //     fontSize: Globals.deviceType == "phone"
          //         ? kTitleLargeFontSize
          //         : kTitleLargeFontSize + kSize,
          //     color: kAccentColor,
          //     fontFamily: 'Roboto-SemiBold'),

          // titleLarge: TextStyle(
          //     fontSize: Globals.deviceType == "phone"
          //         ? kSubtitleFontSize
          //         : kSubtitleFontSize + kSize,
          //     color: kAccentColor,
          //     fontWeight: FontWeight.normal),
          titleMedium: TextStyle(
              fontSize: kBodyTextMedium,
              // Globals.deviceType == "phone"
              //     ? kSubtitle2FontSize
              //     : kSubtitle2FontSize + kSize,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'Roboto Regular'),
          titleSmall: TextStyle(
              fontSize: kTitleMediumFontSize,

              // Globals.deviceType == "phone"
              //     ? kCaptionFontSize
              //     : kCaptionFontSize + kSize,
              color: kTxtFieldColor,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto Regular',
              height: 1.5),
          // bodyLarge: TextStyle(
          //     fontSize: Globals.deviceType == "phone"
          //         ? kBodyText1FontSize
          //         : kBodyText1FontSize + kSize,
          //     color: kAccentColor,
          //     fontWeight: FontWeight.normal,
          //     fontFamily: 'Roboto Regular',
          //     height: 1.5),
          bodyMedium: TextStyle(
              fontSize: kBodyTextMedium,
              // Globals.deviceType == "phone"
              //     ? kBodyText1FontSize
              //     : kBodyText1FontSize + kSize,
              color: kAccentColor,
              fontFamily: 'Roboto Regular',
              fontWeight: FontWeight.normal,
              height: 1.2),
          bodySmall: TextStyle(
              fontSize: kBodyTextSmall,
              // Globals.deviceType == "phone"
              //     ? kbodyTextMedium
              //     : kbodyTextMedium + kSize,
              color: kTxtFieldColor,
              fontFamily: 'Roboto Regular',
              fontWeight: FontWeight.normal,
              height: 1.5)),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: kTxtFieldColor),
        // contentPadding:
        //     const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintStyle: TextStyle(
            color: kTxtFieldColor,
            //  height: 1.2,
            fontSize: kSubtitleFontSize
            // Globals.deviceType == "phone"
            //     ? kSubtitleFontSize
            //     : kSubtitleFontSize + kSize
            ),
        // focusedBorder: OutlineInputBorder(
        //     borderSide: const BorderSide(
        //         width: kBorderWidth, color: kTxtfieldBorderColor),
        //     borderRadius: BorderRadius.circular(kBorderRadius)),
        // enabledBorder: OutlineInputBorder(
        //     borderSide: const BorderSide(
        //         width: kBorderWidth, color: kTxtfieldBorderColor),
        //     borderRadius: BorderRadius.circular(kBorderRadius))
      ));
}
