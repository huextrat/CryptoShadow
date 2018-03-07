import 'package:flutter/material.dart';

class Colors {

  const Colors();

  static const Color appBarTitle = const Color(0xFFFFFFFF);
  static const Color appBarIconColor = const Color(0xFFFFFFFF);
  static const Color appBarDetailBackground = const Color(0x00FFFFFF);
  static const Color appBarGradientStart = const Color(0xFFee0979);
  static const Color appBarGradientEnd = const Color(0xFFff6a00);

  static const Color cryptoCard = const Color(0xFFFFFFFF);

  static const Color cryptoTitle = const Color(0xBB000000);
  static const Color cryptoCurrentPrice = const Color(0x99000000);
  static const Color cryptoLast = const Color(0xFF000000);

  static const Color colorWhite = const Color(0xFFFFFFFF);
  static const Color colorBlack = const Color(0xFF000000);
  static const Color colorBlack2 = const Color(0x99000000);
}

class Dimens {
  const Dimens();

  static const cryptoWidth = 80.0;
  static const cryptoHeight = 80.0;
}

class TextStyles {

  const TextStyles();

  static final baseTextStyle = const TextStyle(
      fontFamily: 'Poppins'
  );

  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 12.0,
  );

  static final commonTextStyle = baseTextStyle.copyWith(
      color: Colors.colorBlack2,
      fontSize: 17.0,
      fontWeight: FontWeight.w400
  );

  static final commonTextStyle14 = baseTextStyle.copyWith(
      color: Colors.colorBlack2,
      fontSize: 16.0,
      fontWeight: FontWeight.w400
  );

  static final commonTextStyleWhite = baseTextStyle.copyWith(
      color: Colors.colorWhite,
      fontSize: 17.0,
      fontWeight: FontWeight.w400
  );

  static final titleTextStyle = baseTextStyle.copyWith(
      color: Colors.colorBlack,
      fontSize: 18.0,
      fontWeight: FontWeight.w600
  );

  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.colorWhite,
      fontSize: 20.0,
      fontWeight: FontWeight.w400
  );


}