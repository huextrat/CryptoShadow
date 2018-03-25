import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto_shadow/database/database_client.dart';
import 'package:crypto_shadow/theme.dart' as Theme;
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
                onPressed: () =>
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=>new AddCoinPage(),
                        fullscreenDialog: true,
                      ),
                    ),
              ),

          ),
        ],
      ),
      /**
      floatingActionButton: new FloatingActionButton(

        backgroundColor: Theme.Colors2.appBarGradientEnd,
        child: new Icon(
          Icons.add, color: Colors.white,
        ),
        onPressed: () =>
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context)=>new AddCoinPage(),
                fullscreenDialog: true,
              ),
            ),
      ),**/
    );
  }

  Future getDatabase() async{

    await db.create();
    portfolio = await db.fetchEveryone();

    this.setState(() {

      portfolio.forEach((port){

        data.forEach((d){
          if(d["symbol"] == port.symbol.toString().toUpperCase()){
            _total += double.parse(d["price_usd"])*double.parse(port.amount);
          }
        });

        _coins.add({
          'symbol': "${port.symbol}",
          'buyPriceUSD': double.parse("${port.priceUSD}"),
          'amount': double.parse("${port.amount}"),
        });
      });

      // ignore: undefined_operator, strong_mode_uses_dynamic_as_bottom
      _stake = (_coins.map((coin)=>coin['buyPriceUSD']*coin['amount']).reduce((double a, double b) => a + b));
      // ignore: undefined_operator, strong_mode_uses_dynamic_as_bottom
      //_total = _total - _stake;
    });
  }

  Future<bool> getDataFromLocal() async {
    try {
      File file = await getLocalFile();
      String contents = await file.readAsString();

      this.setState(() {
        data = JSON.decode(contents);
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
    getDatabase();
  }

}

class RowWithMenu extends StatelessWidget {
  @override
  Widget build (BuildContext ctx) {
    return new Container(
        margin: new EdgeInsets.only(left: 15.0, top: 32.0),
        child: new BackButton(color: Colors.white),
    );
  }
}