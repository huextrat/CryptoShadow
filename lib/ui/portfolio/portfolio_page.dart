import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto_shadow/database/database_client.dart';
import 'package:crypto_shadow/model/cryptos.dart';
import 'package:crypto_shadow/model/portfolio.dart';
import 'package:crypto_shadow/theme.dart' as Theme;
import 'package:crypto_shadow/ui/common/separator.dart';
import 'package:crypto_shadow/ui/portfolio/add_coin_page.dart';
import 'package:crypto_shadow/ui/portfolio/portfolio_chart.dart';
import 'package:crypto_shadow/ui/portfolio/portfolio_header.dart';
import 'package:crypto_shadow/ui/portfolio/portfolio_list.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PortfolioPage extends StatefulWidget {
  final String title;
  PortfolioPage({Key key, this.title}) : super(key: key);

  @override
  PortfolioPageState createState() => new PortfolioPageState();
}

class PortfolioPageState extends State<PortfolioPage> {

  List<Object> _coins = [];

  double _total = 0.0;
  double _stake = 0.0;

  List data;

  List portfolio;
  DatabaseClient db = new DatabaseClient();

  final TextEditingController _controllerSymbol = new TextEditingController();
  final TextEditingController _controllerPriceUSD = new TextEditingController();
  final TextEditingController _controllerAmount = new TextEditingController();

  void save() async{

    bool isSymbol = false;

    await db.create();
    Portfolio portfolio = new Portfolio();

    data.forEach((d){
      if(d["symbol"] == _controllerSymbol.text.toUpperCase()){
        portfolio.symbol = _controllerSymbol.text;
        isSymbol = true;
      }
    });

    if(isSymbol){
      portfolio.priceUSD = _controllerPriceUSD.text;
      portfolio.amount = _controllerAmount.text;
      portfolio = await db.insertPortfolio(portfolio);
      await db.close();

      _controllerSymbol.clear();
      _controllerAmount.clear();
      _controllerPriceUSD.clear();


      Navigator.pop(context);
      await getDataFromLocal();
    }
    else {
      _controllerSymbol.clear();
      _controllerSymbol.value = new TextEditingValue(text: "Unknown crypto");
      _controllerAmount.clear();
      _controllerPriceUSD.clear();
    }
    /**
        else {
        _controllerSymbol.clear();
        Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text('This crypto is unknown.')
        ));
        }**/
  }

  _showDialog(BuildContext ctx) async {
    await showDialog<String>(
      context: ctx,
      child: new Dialog(
          child: new AnimatedContainer(
            //padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
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

            child: new Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                new Container(
                  margin: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
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
                            autofocus: true,
                            controller: _controllerSymbol,
                            onChanged: (newValue) {
                              setState(() {
                                if(newValue.trim().length == 0){
                                  _controllerPriceUSD.clear();
                                }
                                data.forEach((d){
                                  if(d["symbol"] == newValue.trim().toUpperCase()){
                                    _controllerPriceUSD.text = d["price_usd"];
                                  }
                                });
                              });
                            },
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            style: Theme.TextStyles.commonTextStyle,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              contentPadding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                              hintStyle: Theme.TextStyles.commonTextStyle,
                              labelStyle: Theme.TextStyles.commonTextStyle,
                              labelText: "Symbol *",
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ]
                    ),
                    new Separator(),
                    new Stack(
                        alignment: const Alignment(1.0, 0.5),
                        children: <Widget>[
                          new TextField(
                            controller: _controllerPriceUSD,
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            style: Theme.TextStyles.commonTextStyle,

                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              contentPadding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                              hintStyle: Theme.TextStyles.commonTextStyle,
                              labelStyle: Theme.TextStyles.commonTextStyle,
                              labelText: "Buy Price in USD *",
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ]
                    ),
                    new Separator(),
                    new Stack(
                        alignment: const Alignment(1.0, 0.5),
                        children: <Widget>[
                          new TextField(
                            controller: _controllerAmount,
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            style: Theme.TextStyles.commonTextStyle,

                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              contentPadding: new EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                              hintStyle: Theme.TextStyles.commonTextStyle,
                              labelStyle: Theme.TextStyles.commonTextStyle,
                              labelText: "Amount Bought *",
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ]
                    ),

                  ],),
                ),
                new Container(
                  margin: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: new MaterialButton(
                    minWidth: 200.0,
                    onPressed: () => save(),
                    child: new Text('Save', style: Theme.TextStyles.commonTextStyleWhite,),
                    color: Theme.Colors2.colorBlue,
                  ),
                ),
              ],
            ),
          ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: [
          new Stack(children: <Widget>[
            new Container(
              height: 230.0,
              child: new PortfolioHeader(total: _total, stake: _stake, fiat: "USD"),
            ),
            new RowWithMenu(),
          ]),
          new Expanded(
              child: new ListView(children: <Widget>[
                _coins.length == 0
                    ? new Center(child: new CircularProgressIndicator(backgroundColor: Theme.Colors2.appBarGradientEnd))
                    : new PortfolioChart(data: _coins),
                new PortfolioList(coins: _coins, fiat: 'USD',),
              ],),
          ),
          new Container(
            padding: new EdgeInsets.only(bottom: 5.0, top: 5.0),
            child:
              new FloatingActionButton(

                backgroundColor: Theme.Colors2.appBarGradientEnd,
                child: new Icon(
                  Icons.add, color: Colors.white,
                ),
                onPressed: () => _showDialog(context),/**
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=>new AddCoinPage(),
                        fullscreenDialog: true,
                      ),
                    ), **/
              ),

          ),
        ],
      ),
    );
  }

  Future<bool> getDataFromLocal() async {
    try {
      _coins = [];
      data = null;

      File file = await getLocalFile();
      String contents = await file.readAsString();

      await db.create();
      portfolio = await db.fetchEveryone();

      this.setState(() {
        data = JSON.decode(contents);

        this.setState(() {

          portfolio.forEach((port){

            data.forEach((d){
              if(d["symbol"] == port.symbol.toString().toUpperCase()){
                _total += double.parse(d["price_usd"])*double.parse(port.amount);
              }
            });

            _coins.add({
              'id': "${port.id}",
              'symbol': "${port.symbol}",
              'buyPriceUSD': double.parse("${port.priceUSD}"),
              'amount': double.parse("${port.amount}"),
            });
          });

          if(_coins.length>0){
            // ignore: undefined_operator, strong_mode_uses_dynamic_as_bottom
            _stake = (_coins.map((coin)=>coin['buyPriceUSD']*coin['amount']).reduce((double a, double b) => a + b));
          }
        });
      });

      return true;
    } on FileSystemException {
      return false;
    }
  }

  Future<File> getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/coin_list.txt');
  }

  @override
  void initState() {
    super.initState();
    getDataFromLocal();
  }

}

class RowWithMenu extends StatelessWidget {
  @override
  Widget build (BuildContext ctx) {
    return new Container(
        margin: new EdgeInsets.only(left: 10.0, top: 32.0),
        child: new BackButton(color: Colors.white),
    );
  }
}