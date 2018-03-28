import 'package:crypto_shadow/model/cryptos.dart';
import 'package:flutter/material.dart';

import 'package:crypto_shadow/database/database_client.dart';
import 'package:crypto_shadow/ui/portfolio/portfolio_page.dart';

import 'package:crypto_shadow/theme.dart' as Theme;


class PortfolioList extends StatelessWidget {

  final List<Object> coins;
  final String fiat;

  @override
  PortfolioList({this.coins, this.fiat});

  void removeIdPortfolio(int id, BuildContext context) async {
    DatabaseClient db = new DatabaseClient();
    await db.create();
    await db.deletePortfolio(id);
    await db.close();

    Navigator.of(context).pushReplacement(
      new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new PortfolioPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        new FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  _showDialog(Object coin, BuildContext ctx) async {
    await showDialog<String>(
      context: ctx,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(0.0),
        content:
            new Container(
              padding: const EdgeInsets.all(10.0),
              // ignore: undefined_operator
              child: new Text("Are you sure you want to remove it from your Portfolio? \n\n"+coin['symbol'].toString().toUpperCase() + " | " + coin['amount'].toString() + " | " + coin['buyPriceUSD'].toString(), style: Theme.TextStyles.commonTextStyleWhite,),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [Theme.Colors2.appBarGradientStart, Theme.Colors2.appBarGradientEnd],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
            ),

        actions: <Widget>[

          new FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(ctx);
              }),
          new FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(ctx);
                // ignore: undefined_operator
                removeIdPortfolio(int.parse(coin['id']), ctx);
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    // ignore: undefined_operator
    coins.sort((a, b) => a['buyPriceUSD']*a['amount'] > b['buyPriceUSD']*b['amount'] ? -1 : 1);


    List<DataRow> rows = new List.generate(coins.length, (int i) {
      Object coin = coins[i];
      return new DataRow(cells: [
        // ignore: undefined_operator
        new DataCell(new Text(coin['symbol'].toString().toUpperCase()), onTap: ()=> _showDialog(coin, ctx),),//RemovePortfolioId.removeIdPortfolio(int.parse(coin['id']), ctx),),
        // ignore: undefined_operator
        new DataCell(new Text(coin['amount'].toStringAsFixed(6) + " * " + coin['buyPriceUSD'].toStringAsFixed(6)), onTap: ()=> _showDialog(coin, ctx),),
        // ignore: undefined_operator
        //new DataCell(new Text(coin['buyPriceUSD'].toStringAsFixed(6)), onTap: ()=> _showDialog(coin, ctx),),
      ]);
    });

    

    return new DataTable(
        columns: [
          new DataColumn(label: new Text('Symbol'), numeric: false, tooltip: "Crypto symbol"),
          new DataColumn(label: new Text('Amount * Buy Price USD'), numeric: false, tooltip: "Amount * Buy Price USD"),
          //new DataColumn(label: new Text('Buy Price USD'), numeric: false, tooltip: "Buy price USD"),
        ],
        rows: rows,

    );
  }
}

class RemovePortfolioId {
  void removeIdPortfolio(int id, BuildContext context) async {
    DatabaseClient db = new DatabaseClient();
    await db.create();
    await db.deletePortfolio(id);
    await db.close();

    Navigator.of(context).pushReplacement(
      new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new PortfolioPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        new FadeTransition(opacity: animation, child: child),
      ),
    );
  }
}