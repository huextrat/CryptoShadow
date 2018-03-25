import 'package:crypto_shadow/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  runApp(new MaterialApp(
    title: "CryptoShadow",
    home: new HomePage(),
  ));
}
