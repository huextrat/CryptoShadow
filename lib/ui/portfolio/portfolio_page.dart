import 'package:crypto_shadow/ui/portfolio/add_coin_page.dart';
import 'package:crypto_shadow/ui/portfolio/portfolio_chart.dart';
import 'package:crypto_shadow/ui/portfolio/portfolio_header.dart';
import 'package:crypto_shadow/ui/portfolio/portfolio_list.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _coins = [];
    _coins.add({
      'symbol': "GNT",
      'amount': 10.0,
      'value':  2000.0,
    });
    _coins.add({
      'symbol': "REQ",
      'amount': 2000.0,
      'value':  200.0,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: [
          new Stack(children: <Widget>[
            new Container(
              height: 230.0,
              child: new PortfolioHeader(total: 1000.0, stake: 100.0, fiat: "USD"),
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
          onPressed: () => Navigator.of(context).push(
            new MaterialPageRoute(builder: (BuildContext context)=>new AddCoinPage(),
            fullscreenDialog: true,
            ),
            /**
            new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new AddCoinPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              new FadeTransition(opacity: animation, child: child),
            ),**/
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