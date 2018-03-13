import 'dart:async';

import 'package:crypto_shadow/model/cryptos.dart';
import 'package:crypto_shadow/model/historical_data.dart';
import 'package:crypto_shadow/ui/common/crypto_summary.dart';
import 'package:crypto_shadow/ui/common/separator.dart';
import 'package:flutter/material.dart';
import 'package:crypto_shadow/Theme.dart' as Theme;

class DetailPage extends StatefulWidget {
  Crypto crypto;
  DetailPage({Key key, this.crypto}) : super(key: key);

  @override
  DetailPageState createState() => new DetailPageState();
}

class DetailPageState extends State<DetailPage> {

  Map<String, List> data;

  @override
  void initState() {
    super.initState();
  }

  HistoricalData getPrice(int index) {
    return new HistoricalData(
      data['Data'][index]['time'],
      data['Data'][index]['close'],
      data['Data'][index]['high'],
      data['Data'][index]['low'],
      data['Data'][index]['open'],
      data['Data'][index]['volumefrom'],
      data['Data'][index]['volumeto'],
    );
  }

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
    final _chart24h = "Chart (24h)".toUpperCase();
    final _chart7d = "Chart (7d)".toUpperCase();
    final _chart30d = "Chart (30d)".toUpperCase();
    final _chart1y = "Chart (1y)".toUpperCase();
    final _overviewVolume = "Market Cap".toUpperCase();

    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 32.0),
        children: <Widget>[
          new CryptoSummary(widget.crypto,
            horizontal: false,
          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 15.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                new Text(_overviewVolume,
                  style: Theme.TextStyles.headerTextStyle,),
                new Separator(),
                new Text(
                    "\$"+widget.crypto.formatCurrency(widget.crypto.marketCapUsd).substring(0, widget.crypto.formatCurrency(widget.crypto.marketCapUsd).length - 3)+"\n\n", style: Theme.TextStyles.commonTextStyleWhite),


                new Text(_chart24h,
                  style: Theme.TextStyles.headerTextStyle,),
                new Separator(),
                new Center(
                  child: new FadeInImage(
                      placeholder: new AssetImage("assets/loading.gif"),
                      image: new NetworkImage("https://cryptohistory.org/charts/light/"+widget.crypto.symbol+"-usd/24h/png"), fit: BoxFit.fill, height: 180.0,
                      fadeOutDuration: new Duration(milliseconds: 200),
                      fadeOutCurve: Curves.decelerate,
                  ),
                ),

                new Text(_chart7d,
                  style: Theme.TextStyles.headerTextStyle,),
                new Separator(),
                new Center(
                  child: new FadeInImage(
                    placeholder: new AssetImage("assets/loading.gif"),
                    image: new NetworkImage("https://cryptohistory.org/charts/light/"+widget.crypto.symbol+"-usd/7d/png"), fit: BoxFit.fill, height: 180.0,
                    fadeOutDuration: new Duration(milliseconds: 200),
                    fadeOutCurve: Curves.decelerate,
                  ),
                ),

                new Text(_chart1y,
                  style: Theme.TextStyles.headerTextStyle,),
                new Separator(),
                new Center(
                  child: new FadeInImage(
                    placeholder: new AssetImage("assets/loading.gif"),
                    image: new NetworkImage("https://cryptohistory.org/charts/light/"+widget.crypto.symbol+"-usd/1y/png"), fit: BoxFit.fill, height: 180.0,
                    fadeOutDuration: new Duration(milliseconds: 200),
                    fadeOutCurve: Curves.decelerate,
                  ),
                ),
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