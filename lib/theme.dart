import 'package:flutter/material.dart';

Color getSymbolColor(String symbol) {
  Map<String, Color> colors = {
    'ETH': Colors.orange,
    'EOS': Colors.grey[200],
    'REQ': Colors.blue[200],
    'REP': Colors.blueGrey[200],
    'SALT': Colors.brown[200],
    'OMG': Colors.cyan[200],
    'VIU': Colors.deepOrange[200],
    'XVG': Colors.deepPurple[200],
    'RDN': Colors.green[200],
    'XMR': Colors.indigo[200],
    'ADA': Colors.lightBlue[200],
    'BCH': Colors.lime[200],
    'BTC': Colors.orange[200],
    'USDT': Colors.purple[200],
    'LTC': Colors.red[200],
    'XLM': Colors.red[600],
    'NEO': Colors.green[400],
    'MIOTA': Colors.grey[500],
    'DASH': Colors.blue[400],
    'TRX': Colors.pink[400],
    'XEM': Colors.blue[200],
    'VEN': Colors.blue[700],
    'ETC': Colors.lightGreen[700],
    'QTUM': Colors.blue[300],
    'BNB': Colors.yellow[700],
    'BTG': Colors.yellow[300],
    'DOGE': Colors.amber[200],
  };
  if (!colors.containsKey(symbol)) {
    return Colors.black;
  } else {
    return colors[symbol];
  }
}

class Colors2 {

  const Colors2();

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

  static const Color colorBlue = const Color(0xFF2196F3);

  static const primaryGradient = const LinearGradient(
    colors: const [const Color(0xFFee0979), const Color(0xFFff6a00)],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
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
      color: Colors2.colorBlack2,
      fontSize: 17.0,
      fontWeight: FontWeight.w400
  );

  static final commonTextStyle14 = baseTextStyle.copyWith(
      color: Colors2.colorBlack2,
      fontSize: 16.0,
      fontWeight: FontWeight.w400
  );

  static final commonTextStyleWhite = baseTextStyle.copyWith(
      color: Colors2.colorWhite,
      fontSize: 17.0,
      fontWeight: FontWeight.w400
  );

  static final titleTextStyle = baseTextStyle.copyWith(
      color: Colors2.colorBlack,
      fontSize: 18.0,
      fontWeight: FontWeight.w600
  );

  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors2.colorWhite,
      fontSize: 20.0,
      fontWeight: FontWeight.w400
  );


}