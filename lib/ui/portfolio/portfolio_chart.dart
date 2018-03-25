import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:crypto_shadow/theme.dart' as Theme;

class PortfolioChart extends StatelessWidget {

  final List<Object> data;
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
  PortfolioChart({this.data});

  @override
  Widget build(BuildContext ctx) {
    List<CircularSegmentEntry> stacks = new List.generate(this.data.length, (int i) {
      // ignore: undefined_operator
      return new CircularSegmentEntry(this.data[i]['amount']*this.data[i]['buyPriceUSD'], Theme.getSymbolColor(this.data[i]['symbol'].toString().toUpperCase()));
    });
    return new AnimatedCircularChart(
      duration: const Duration(milliseconds: 1000),
      key: _chartKey,
      size: const Size(280.0, 230.0),
      initialChartData: [new CircularStackEntry(stacks)],
      chartType: CircularChartType.Radial,
    );
  }

}