import 'package:crypto_shadow/ui/common/separator.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:crypto_shadow/ui/common/gradient_appbar_with_back.dart';
import 'package:launch_review/launch_review.dart';
import 'package:crypto_shadow/theme.dart' as Theme;

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => new SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  Map data;

  @override
  void initState() {
    super.initState();
  }

  void rateThisApp() {
    LaunchReview.launch(androidAppId: "com.huextrat.cryptoshadow",
        iOSAppId: "TODO");
  }

  void shareThisApp() {
    Share.share("#CryptoShadow is a new cryptocurrency tracker built with @flutterio : https://play.google.com/store/apps/details?id=com.huextrat.cryptoshadow");
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Theme.Colors2.appBarGradientStart, Theme.Colors2.appBarGradientEnd],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp
          ),
        ),

        child: new Column(
          children: <Widget>[
            new GradientAppBarWithBack("Settings"),

            new Container(
              margin: new EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0.0),

              decoration: new BoxDecoration(
                color: new Color(0xFFFFFFFF),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: new Color(0xFFee0979),
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.fromLTRB(150.0, 10.0, 150.0, 10.0),
                    child: new Text("Version: 2.1",),
                  ),
                  new Separator(),
                ],
              ),
            ),
            new ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new MaterialButton(
                  child: new Text('Review This App', style: Theme.TextStyles.commonTextStyle,),
                  color: Theme.Colors2.colorWhite,
                  onPressed: () {
                    rateThisApp();
                  },
                ),
                new MaterialButton(
                  child: new Text('Share This App', style: Theme.TextStyles.commonTextStyle,),
                  color: Theme.Colors2.colorWhite,
                  onPressed: () {
                    shareThisApp();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
