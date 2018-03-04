import 'package:crypto_shadow/model/cryptos.dart';
import 'package:crypto_shadow/ui/common/crypto_summary.dart';
import 'package:crypto_shadow/ui/common/separator.dart';
import 'package:flutter/material.dart';
import 'package:crypto_shadow/Theme.dart' as Theme;

class DetailPage extends StatelessWidget {

  final Crypto crypto;

  DetailPage(this.crypto);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Theme.Colors.appBarGradientStart, Theme.Colors.appBarGradientEnd],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp
          ),
        ),
        //color: new Color(0xFF736AB7),
        child: new Stack (
          children: <Widget>[
            _getContent(),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }


  Container _getContent() {
    final _overviewTitle = "General".toUpperCase();
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          new CryptoSummary(crypto,
            horizontal: false,
          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_overviewTitle,
                  style: Theme.TextStyles.headerTextStyle,),
                new Separator(),
                new Text(
                    crypto.description, style: Theme.TextStyles.commonTextStyleWhite),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .padding
              .top),
      child: new BackButton(color: Colors.white),
    );
  }
}