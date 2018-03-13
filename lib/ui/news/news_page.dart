import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto_shadow/Theme.dart' as Theme;
import 'package:crypto_shadow/model/fiat.dart';
import 'package:crypto_shadow/ui/common/gradient_appbar_with_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);
  @override
  NewsPageState createState() => new NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  var newsSelection = "crypto-coins-news";

  String apiKey = "97ec2e1bd66c4a83bea5a50471589972";

  var data;

  final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Theme.Colors.appBarGradientStart,
                Theme.Colors.appBarGradientEnd
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: new Stack(
          children: <Widget>[
            new GradientAppBarWithBack("News"),
            new Container(
              padding: new EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 15.0),
              child: data == null
                  ? const Center(child: const CircularProgressIndicator())
                  : data["articles"].length != 0
                      ? new RefreshIndicator(onRefresh: refresh, child: new ListView.builder(
                          itemCount: data == null ? 0 : data["articles"].length,
                          padding: new EdgeInsets.all(8.0),
                          itemBuilder: (BuildContext context, int index) {
                            return new Card(
                              elevation: 1.7,
                              child: new Padding(
                                padding: new EdgeInsets.all(10.0),
                                child: new Column(
                                  children: [
                                    new Row(
                                      children: <Widget>[
                                        new Padding(
                                          padding:
                                              new EdgeInsets.only(left: 4.0),
                                          child: new Text(
                                            timeAgo(DateTime.parse(
                                                data["articles"][index]
                                                    ["publishedAt"])),
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ),
                                        new Padding(
                                          padding: new EdgeInsets.all(5.0),
                                          child: new Text(
                                            data["articles"][index]["source"]
                                                ["name"],
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    new Row(
                                      children: [
                                        new Expanded(
                                          child: new GestureDetector(
                                            child: new Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                new Padding(
                                                  padding: new EdgeInsets.only(
                                                      left: 4.0,
                                                      right: 8.0,
                                                      bottom: 8.0,
                                                      top: 8.0),
                                                  child: new Text(
                                                    data["articles"][index]
                                                        ["title"],
                                                    style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                new Padding(
                                                  padding: new EdgeInsets.only(
                                                      left: 4.0,
                                                      right: 4.0,
                                                      bottom: 4.0),
                                                  child: new Text(
                                                    data["articles"][index]
                                                        ["description"],
                                                    style: new TextStyle(
                                                      color: Colors.grey[500],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              flutterWebviewPlugin.launch(
                                                  data["articles"][index]
                                                      ["url"],
                                                  fullScreen: false);
                                            },
                                          ),
                                        ),
                                        new Column(
                                          children: <Widget>[
                                            new Padding(
                                              padding:
                                                  new EdgeInsets.only(top: 8.0),
                                              child: new SizedBox(
                                                height: 100.0,
                                                width: 100.0,
                                                child: new Image.network(
                                                  data["articles"][index]
                                                      ["urlToImage"],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
              ),
                        )
                      : new Center(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Icon(Icons.chrome_reader_mode,
                                  color: Colors.grey, size: 60.0),
                              new Text(
                                "No articles saved",
                                style: new TextStyle(
                                    fontSize: 24.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Future getData() async {
    var response = await http.get(
        Uri.encodeFull(
            'https://newsapi.org/v2/everything?sources=' + newsSelection),
        headers: {
          "Accept": "application/json",
          "X-Api-Key": apiKey,
        });
    var localData = JSON.decode(response.body);
    if (localData != null && localData["articles"] != null) {
      localData["articles"].sort((a, b) =>
          a["publishedAt"] != null && b["publishedAt"] != null
              ? b["publishedAt"].compareTo(a["publishedAt"])
              : null);
    }

    this.setState(() {
      data = localData;
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
}
