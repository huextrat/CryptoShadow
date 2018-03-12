import 'package:crypto_shadow/model/cryptos.dart';
import 'package:crypto_shadow/model/fiat.dart';
import 'package:crypto_shadow/ui/common/separator.dart';
import 'package:crypto_shadow/ui/detail/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:crypto_shadow/Theme.dart' as Theme;

class FiatSummary extends StatelessWidget {

  final Fiat fiat;
  final bool horizontal;

  FiatSummary(this.fiat, {this.horizontal = true});

  FiatSummary.vertical(this.fiat): horizontal = false;


  @override
  build(BuildContext context) {

    final cryptoThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 23.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,

    );

    final cryptoCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 39.0 : 16.0, horizontal ? 15.0 : 45.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(fiat.name+" ("+fiat.code+")"),
          new Container(height: 1.0),

          new Separator(),

        ],
      ),
    );

  }
}

IconData getIcon(bool isNegative) {
  IconData icon;
  isNegative ? icon = Icons.arrow_drop_down : icon = Icons.arrow_drop_up;
  return icon;
}