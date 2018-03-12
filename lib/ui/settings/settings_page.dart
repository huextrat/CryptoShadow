import 'package:crypto_shadow/ui/common/gradient_appbar.dart';
import 'package:crypto_shadow/ui/common/gradient_appbar_with_back.dart';
import 'package:crypto_shadow/ui/common/separator.dart';
import 'package:crypto_shadow/ui/home/home_page_body.dart';
import 'package:flutter/material.dart';
import 'package:crypto_shadow/Theme.dart' as Theme;

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Theme.Colors.appBarGradientStart, Theme.Colors.appBarGradientEnd],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp
          ),
        ),
        child: new GradientAppBarWithBack("Settings"),
      ),
    );
  }
}
