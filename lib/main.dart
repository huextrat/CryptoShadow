import 'package:crypto_shadow/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:onesignal/onesignal.dart';

void main() {

  OneSignal.shared.init("c67e6825-3be5-478a-a39a-aaf6bc2641cf");

  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp ]);

  _firebaseMessaging.requestNotificationPermissions();

  runApp(new MaterialApp(
    title: "CryptoShadow",
    home: new HomePage(),
  ));
}
