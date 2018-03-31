import 'package:crypto_shadow/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() {

  FirebaseAnalytics analytics = new FirebaseAnalytics();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  runApp(new MaterialApp(
    title: "CryptoShadow",
    home: new HomePage(),
  ));
}
