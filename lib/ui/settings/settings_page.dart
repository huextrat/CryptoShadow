import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto_shadow/model/fiat.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_shadow/ui/common/gradient_appbar_with_back.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto_shadow/Theme.dart' as Theme;


class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => new SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  Map data;

  Future getData() async {
    var response = await http.get(
        Uri.encodeFull(
            'https://openexchangerates.org/api/currencies.json'),
        headers: {
          "Accept": "application/json",
        });

    this.setState(() {
      data = JSON.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  refresh() async {
    await getData();
  }

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

        child: new Stack(
          children: <Widget>[
            new GradientAppBarWithBack("Settings"),
            new Container(
              margin: new EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 300.0),

              decoration: new BoxDecoration(
                color: new Color(0xFFFFFFFF),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(30.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: new Color(0xFFee0979),
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0),
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
