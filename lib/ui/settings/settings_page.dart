import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto_shadow/model/fiat.dart';
import 'package:crypto_shadow/ui/common/fiat_summary.dart';
import 'package:crypto_shadow/ui/common/gradient_appbar_with_back.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto_shadow/Theme.dart' as Theme;
import 'package:http/http.dart' as http;


class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => new SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  List data;

  Future<bool> getDataFromLocal() async {
    try {
      File file = new File("assets/FIAT.json");
      // read the variable as a string from the file.
      String contents = await file.readAsString();

      data = JSON.decode(contents);
      print(data);

      return true;
    } on FileSystemException {
      return false;
    }
  }

  @override
  void initState() {
    this.getDataFromLocal();
  }

  Fiat getFiat(int index) {
    return new Fiat(
      data[index]["symbol"],
      data[index]["name"],
      data[index]["symbol_native"],
      data[index]["decimal_digits"],
      data[index]["rounding"],
      data[index]["code"],
      data[index]["name_plural"],
    );
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

        child: new Column(
          children: <Widget>[
            new GradientAppBarWithBack("Settings"),
            /*
            new ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  child: new Text(data[index]["name"]),
                );
              },
            ),
            */
          ],
        ),

        //child: new GradientAppBarWithBack("Settings"),
      ),
    );
  }
}
