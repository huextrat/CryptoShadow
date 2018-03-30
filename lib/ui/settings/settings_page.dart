import 'package:flutter/material.dart';

import 'package:crypto_shadow/ui/common/gradient_appbar_with_back.dart';

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

        child: new Stack(
          children: <Widget>[
            new GradientAppBarWithBack("Settings"),

            new Container(
              margin: new EdgeInsets.fromLTRB(5.0, 100.0, 5.0, 0.0),

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
              child: new Row(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 10.0),
                    child: new Text("Version: 2.0.0",),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
