import 'package:crypto_shadow/ui/detail/crypto_summary_full.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:crypto_shadow/model/cryptos.dart';
import 'package:crypto_shadow/ui/common/separator.dart';

import 'package:crypto_shadow/theme.dart' as Theme;


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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Theme.Colors2.appBarGradientStart, Theme.Colors2.appBarGradientEnd],
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

  final TextEditingController _controllerCrypto = new TextEditingController();
  final TextEditingController _controllerUSD = new TextEditingController();

  String cryptoStr = "";
  String usdStr = "";

  Container _getContent() {
    final _comparator = "Converter".toUpperCase();
    final _chart24h = " (24h)".toUpperCase();
    final _chart7d = " (7d)".toUpperCase();
    final _chart1y = " (1y)".toUpperCase();
    final _overviewVolume = "Market Cap".toUpperCase();

    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 32.0),
        children: <Widget>[

          new CryptoSummaryFull(widget.crypto,
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
                    "\$"+widget.crypto.formatCurrency(widget.crypto.marketCapUsd).substring(0, widget.crypto.formatCurrency(widget.crypto.marketCapUsd).length - 3)+"\n", style: Theme.TextStyles.commonTextStyleWhite),

                new Text(_comparator,
                  style: Theme.TextStyles.headerTextStyle,),
                new Separator(),

                new Container(
                  margin: new EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),

                  decoration: new BoxDecoration(
                    color: new Color(0xFFFFFFFF),
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(10.0),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: new Color(0xFFee0979),
                        blurRadius: 10.0,
                        offset: new Offset(0.0, 10.0),
                      ),
                    ],
                  ),

                  child: new Column(children: <Widget>[
                    new Stack(
                        alignment: const Alignment(1.0, 0.5),
                        children: <Widget>[
                          new TextField(
                            controller: _controllerCrypto,
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            style: Theme.TextStyles.commonTextStyle,
                            onChanged: (newValue) {
                              setState(() {
                                cryptoStr = newValue.trim();
                                if(usdStr.length==0){
                                  _controllerUSD.text = " ";
                                }
                                _controllerUSD.text = (double.parse(cryptoStr)*double.parse(widget.crypto.priceUsd)).toString();
                              });
                            },
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              contentPadding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                              hintStyle: Theme.TextStyles.commonTextStyle,
                              labelStyle: Theme.TextStyles.commonTextStyle,
                              labelText: widget.crypto.symbol,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          new FlatButton(
                              onPressed: () {
                                _controllerCrypto.clear();
                                _controllerUSD.clear();
                              },
                              child: new Icon(Icons.clear, color: Theme.Colors2.appBarGradientEnd,)
                          ),
                        ]
                    ),
                    new Separator(),
                    new Stack(
                        alignment: const Alignment(1.0, 0.5),
                        children: <Widget>[
                          new TextField(
                            controller: _controllerUSD,
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            style: Theme.TextStyles.commonTextStyle,

                            onChanged: (newValue) {
                              setState(() {
                                usdStr = newValue.trim();
                                if(cryptoStr.length==0){
                                  _controllerCrypto.text = " ";
                                }
                                if((double.parse(usdStr)/double.parse(widget.crypto.priceUsd)).toString().length >= 10){
                                  _controllerCrypto.text = (double.parse(usdStr)/double.parse(widget.crypto.priceUsd)).toString().substring(0, 10);
                                }
                                else {
                                  _controllerCrypto.text = (double.parse(usdStr)/double.parse(widget.crypto.priceUsd)).toString();
                                }
                              });
                            },
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              contentPadding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                              hintStyle: Theme.TextStyles.commonTextStyle,
                              labelStyle: Theme.TextStyles.commonTextStyle,
                              labelText: "USD",
                            ),
                            textAlign: TextAlign.center,
                          ),
                          new FlatButton(
                              onPressed: () {
                                _controllerUSD.clear();
                                _controllerCrypto.clear();
                              },
                              child: new Icon(Icons.clear, color: Theme.Colors2.appBarGradientEnd,))
                        ]
                    ),

                  ],),
                ),

                new Text("\n"),

                new Row(
                  children: <Widget>[
                    new Icon(Icons.timeline, color: Theme.Colors2.colorWhite,),
                    new Text(_chart24h, style: Theme.TextStyles.headerTextStyle,),
                  ],
                ),
                new Separator(),

                new Center(
                  child: new FadeInImage(
                      placeholder: new AssetImage("assets/loading.gif"),
                      image: new NetworkImage("https://cryptohistory.org/charts/light/"+widget.crypto.symbol+"-usd/24h/png"), fit: BoxFit.fill, height: 180.0,
                      fadeOutDuration: new Duration(milliseconds: 200),
                      fadeOutCurve: Curves.decelerate,
                  ),
                ),

                new Row(
                  children: <Widget>[
                    new Icon(Icons.timeline, color: Theme.Colors2.colorWhite,),
                    new Text(_chart7d, style: Theme.TextStyles.headerTextStyle,),
                  ],
                ),

                new Separator(),
                new Center(
                  child: new FadeInImage(
                    placeholder: new AssetImage("assets/loading.gif"),
                    image: new NetworkImage("https://cryptohistory.org/charts/light/"+widget.crypto.symbol+"-usd/7d/png"), fit: BoxFit.fill, height: 180.0,
                    fadeOutDuration: new Duration(milliseconds: 200),
                    fadeOutCurve: Curves.decelerate,
                  ),
                ),

                new Row(
                  children: <Widget>[
                    new Icon(Icons.timeline, color: Theme.Colors2.colorWhite,),
                    new Text(_chart1y, style: Theme.TextStyles.headerTextStyle,),
                  ],
                ),
                new Separator(),
                new Center(
                  child: new FadeInImage(
                    placeholder: new AssetImage("assets/loading.gif"),
                    image: new NetworkImage("https://cryptohistory.org/charts/light/"+widget.crypto.symbol+"-usd/1y/png"), fit: BoxFit.fill, height: 180.0,
                    fadeOutDuration: new Duration(milliseconds: 200),
                    fadeOutCurve: Curves.decelerate,
                  ),
                ),
                new Padding(padding: new EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 50.0),
          )
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
        left: 10.0,
          top: 32.0),
      child: new BackButton(color: Colors.white),
    );
  }
}