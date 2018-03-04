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
          vertical: 24.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
        tag: "crypto-hero-${crypto.id}",
        child: new Image(
          image: new AssetImage(crypto.image),
          height: 80.0,
          width: 80.0,
        ),
      ),
    );



    Widget _cryptoValue({String value, String image}) {
      return new Container(
        child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Image.asset(image, height: 12.0),
              new Container(width: 8.0),
              new Text(crypto.last24, style: Theme.TextStyles.smallTextStyle),
            ]
        ),
      );
    }


    final cryptoCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 70.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(crypto.name, style: Theme.TextStyles.titleTextStyle),
          new Container(height: 1.0),
          new Text(crypto.currentPrice, style: Theme.TextStyles.commonTextStyle),
          new Separator(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _cryptoValue(
                      value: "% 24h: "+crypto.last24,
                      image: 'assets/img/ic_distance.png')

              )
            ],
          ),
        ],
      ),
    );


    final cryptoCard = new Container(
      child: cryptoCardContent,
      height: horizontal ? 128.0 : 154.0,
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
          ) ,
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