import 'package:flutter/material.dart';

class SeparatorWhite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.fromLTRB(3.0, 30.0, 3.0, 0.0),
        //padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        height: 20.0,
        width: 2.0,
        color: new Color(0xFFffffff)
    );
  }
}