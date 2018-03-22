import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PortfolioList extends StatelessWidget {

  final List<Object> coins;
  final String fiat;

  @override
  PortfolioList({this.coins, this.fiat});

  @override
  Widget build(BuildContext ctx) {
    coins.sort((a, b) => a['value'] > b['value'] ? -1 : 1);
    NumberFormat currencyFormat = new NumberFormat.currency(decimalDigits: 2, name: 'fiat', symbol: ' $fiat ');
    List<DataRow> rows = new List.generate(coins.length, (int i) {
      Object coin = coins[i];
      return new DataRow(cells: [
        new DataCell(new Text(coin['symbol'])),
        new DataCell(new Text(coin['amount'].toStringAsFixed(3))),
        new DataCell(new Text(currencyFormat.format(coin['value']))),
      ]);
    });
    return new DataTable(
        columns: [
          new DataColumn(label: new Text('Symbol')),
          new DataColumn(label: new Text('Amount')),
          new DataColumn(label: new Text('Value')),
        ],
        rows: rows
    );
  }
}