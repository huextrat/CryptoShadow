import 'package:crypto_shadow/model/cryptos.dart';
import 'package:crypto_shadow/model/cryptos.dart';
import 'package:crypto_shadow/ui/common/crypto_summary.dart';
import 'package:flutter/material.dart';
import 'package:crypto_shadow/Theme.dart' as Theme;



class HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Expanded(

      child: new Container(
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
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (context, index) => new CryptoSummary(cryptos[index]),
                  childCount: cryptos.length,
                ),
              ),
            ),

          ],

        ),
      ),
    );
  }
}