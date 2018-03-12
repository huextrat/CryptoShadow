import 'package:crypto_shadow/model/cryptos.dart';
import 'package:crypto_shadow/ui/common/separator.dart';
import 'package:crypto_shadow/ui/detail/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:crypto_shadow/Theme.dart' as Theme;

class CryptoSummary extends StatelessWidget {

  final Crypto crypto;
  final bool horizontal;

  CryptoSummary(this.crypto, {this.horizontal = true});

  CryptoSummary.vertical(this.crypto): horizontal = false;


  @override
  Widget build(BuildContext context) {

    final cryptoThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 23.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,

      child: new Hero(
        tag: "crypto-hero-${crypto.id}",
        child: new Image(
          image: new AssetImage("assets/img/"+crypto.symbol.toLowerCase()+".png"),
          height: 80.0,
          width: 80.0,
        ),

      ),

    );

    final cryptoCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 39.0 : 16.0, horizontal ? 15.0 : 45.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(crypto.rank+". "+crypto.name+ " (" + crypto.symbol + ")", style: Theme.TextStyles.titleTextStyle),
          new Container(height: 1.0),

          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: <Widget>[
              new Expanded(
                flex: horizontal ? 1 : 0,

                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        "\$"+crypto.formatCurrency(crypto.priceUsd).substring(0, crypto.formatCurrency(crypto.priceUsd).length - 4),
                        style: Theme.TextStyles.commonTextStyle,
                      ),
                      new Text(
                        crypto.formatCurrency(crypto.priceUsd).substring(crypto.formatCurrency(crypto.priceUsd).length - 4, crypto.formatCurrency(crypto.priceUsd).length),
                        style: Theme.TextStyles.commonTextStyle14,
                      ),
                    ],
                ),
              ),
            ],
          ),

          new Separator(),

          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                flex: horizontal ? 1 : 0,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    new Text("1h:", style: Theme.TextStyles.smallTextStyle),
                    new Icon(
                      getIcon(double.parse(crypto.percentChange1h).isNegative),
                      color: double.parse(crypto.percentChange1h).isNegative ? Colors.red : Colors.green,
                      size: 20.0,
                    ),
                    new Text(
                      (double.parse(crypto.percentChange1h).isNegative ? "" : "+") + crypto.percentChange1h + "%",
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: double.parse(crypto.percentChange1h).isNegative ? Colors.red : Colors.green,
                      ),
                    ),


                    new Text("  24h:", style: Theme.TextStyles.smallTextStyle),
                    new Icon(
                      getIcon(double.parse(crypto.percentChange24h).isNegative),
                      color: double.parse(crypto.percentChange24h).isNegative ? Colors.red : Colors.green,
                      size: 20.0,
                    ),
                    new Text(
                      (double.parse(crypto.percentChange24h).isNegative ? "" : "+") + crypto.percentChange24h + "%",
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: double.parse(crypto.percentChange24h).isNegative ? Colors.red : Colors.green,
                      ),
                    ),

                    new Text("  7d:", style: Theme.TextStyles.smallTextStyle),
                    new Icon(
                      getIcon(double.parse(crypto.percentChange7d).isNegative),
                      color: double.parse(crypto.percentChange7d).isNegative ? Colors.red : Colors.green,
                      size: 20.0,
                    ),
                    new Text(
                      (double.parse(crypto.percentChange7d).isNegative ? "" : "+") + crypto.percentChange7d + "%",
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: double.parse(crypto.percentChange7d).isNegative ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          /**
          new Padding(
            padding: new EdgeInsets.only(left: 1.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                flex: horizontal ? 1 : 0,
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      new Text("1h: ", style: Theme.TextStyles.smallTextStyle),
                      new Icon(
                        getIcon(double.parse(crypto.percentChange1h).isNegative),
                        color: double.parse(crypto.percentChange1h).isNegative ? Colors.red : Colors.green,
                        size: 20.0,
                      ),
                      new Text(
                        (double.parse(crypto.percentChange1h).isNegative ? "" : "+") + crypto.percentChange1h + "%",
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: double.parse(crypto.percentChange1h).isNegative ? Colors.red : Colors.green,
                        ),
                      ),


                      new Text("   24h: ", style: Theme.TextStyles.smallTextStyle),
                      new Icon(
                        getIcon(double.parse(crypto.percentChange24h).isNegative),
                        color: double.parse(crypto.percentChange24h).isNegative ? Colors.red : Colors.green,
                        size: 20.0,
                      ),
                      new Text(
                        (double.parse(crypto.percentChange24h).isNegative ? "" : "+") + crypto.percentChange24h + "%",
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: double.parse(crypto.percentChange24h).isNegative ? Colors.red : Colors.green,
                        ),
                      ),

                      new Text("   7d: ", style: Theme.TextStyles.smallTextStyle),
                      new Icon(
                        getIcon(double.parse(crypto.percentChange7d).isNegative),
                        color: double.parse(crypto.percentChange7d).isNegative ? Colors.red : Colors.green,
                        size: 20.0,
                      ),
                      new Text(
                        (double.parse(crypto.percentChange7d).isNegative ? "" : "+") + crypto.percentChange7d + "%",
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: double.parse(crypto.percentChange7d).isNegative ? Colors.red : Colors.green,
                        ),
                      ),
                  ],
                ),
                ),
              ],
            ),
          ),**/
          /**
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _cryptoValue(
                      value: "% 24h: ",//+crypto.percentChange24h,
                      image: 'assets/img/ic_distance.png')

              )
            ],
          ),**/
        ],
      ),
    );



    final cryptoCard = new Container(
      child: cryptoCardContent,
      height: horizontal ? 128.0 : 160.0,
      margin: horizontal
          ? new EdgeInsets.only(left: 46.0)
          : new EdgeInsets.only(top: 60.0),
      decoration: new BoxDecoration(
        color: new Color(0xFFFFFFFF),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(80.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: new Color(0xFFee0979),
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );


    return new GestureDetector(
        onTap: horizontal
            ? () => Navigator.of(context).push(
          new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new DetailPage(crypto),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new FadeTransition(opacity: animation, child: child),
          ),
        )
            : null,
        child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              cryptoCard,
              cryptoThumbnail,
            ],
          ),
        )
    );
  }
}

IconData getIcon(bool isNegative) {
  IconData icon;
  isNegative ? icon = Icons.arrow_drop_down : icon = Icons.arrow_drop_up;
  return icon;
}