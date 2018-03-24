import 'dart:async';
import 'dart:io';

import 'package:crypto_shadow/ui/portfolio/add_coin_page.dart';
import 'package:crypto_shadow/ui/portfolio/portfolio_chart.dart';
import 'package:crypto_shadow/ui/portfolio/portfolio_header.dart';
import 'package:crypto_shadow/ui/portfolio/portfolio_list.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto_shadow/theme.dart' as Theme;

class PortfolioPage extends StatefulWidget {
  PortfolioPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  PortfolioPageState createState() => new PortfolioPageState();
}

class PortfolioPageState extends State<PortfolioPage> {

  Object obj;
  List<Object> _coins = [];

  double _total = 0.0;
  double _stake = 0.0;

  String data;

  Future<File> getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/coin_portfolio.txt');
  }

  Future<bool> getDataFromLocal() async {
    try {
      File file = await getLocalFile();
      String contents = await file.readAsString();

      this.setState(() {
        data = contents;
        _coins = [];

        List<String> s1 = data.split("\n");
        print(s1);

        s1.forEach((element){
          List<String> s2 = element.split(";");
          _coins.add({
            'symbol': s2[0],
            'amount': double.parse(s2[1]),
            'buyPriceUSD': double.parse(s2[2]),
          });
        });



        // ignore: undefined_operator, strong_mode_uses_dynamic_as_bottom
        _stake = (_coins.map((coin)=>coin['buyPriceUSD']*coin['amount']).reduce((double a, double b) => a + b));
        // ignore: undefined_operator, strong_mode_uses_dynamic_as_bottom
        _total = _coins.map((coin)=>coin['buyPriceUSD']*coin['amount']).reduce((double a, double b) => a + b);
      });

      return true;
    } on FileSystemException {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromLocal();


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
        ],
      ),
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
      ),
    );
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

class DialogDemoItem extends StatelessWidget {
  const DialogDemoItem({ Key key, this.icon, this.color, this.text, this.onPressed }) : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new SimpleDialogOption(
      onPressed: onPressed,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Icon(icon, size: 36.0, color: color),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Text(text),
          ),
        ],
      ),
    );
  }
}