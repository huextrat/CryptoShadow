import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:crypto_shadow/ui/common/gradient_appbar_with_back.dart';

import 'package:http/http.dart' as http;
import 'package:crypto_shadow/theme.dart' as Theme;


class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);
  @override
  NewsPageState createState() => new NewsPageState();
}


class NewsPageState extends State<NewsPage> with SingleTickerProviderStateMixin {


  var newsSelection = "crypto-coins-news";
  String apiKey = "97ec2e1bd66c4a83bea5a50471589972";
  var data;
  final FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();

  Future getData() async {
    var response = await http.get(
        Uri.encodeFull(
            'https://newsapi.org/v2/everything?sources=' + newsSelection),
        headers: {
          "Accept": "application/json",
          "X-Api-Key": apiKey,
        });
    var localData = json.decode(response.body);

    this.setState(() {
      data = localData;
    });

  }

  @override
  void initState() {
    this.getData();
    super.initState();
  }

  Future refresh() async {
    await getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Theme.Colors2.appBarGradientStart,
                Theme.Colors2.appBarGradientEnd
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

              padding: new EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
              child: data == null
                  ? const Center(child: const CircularProgressIndicator())
                  : data["articles"].length != 0
                      ? new RefreshIndicator(onRefresh: refresh, child: new ListView.builder(
                          itemCount: data == null ? 0 : data["articles"].length,
                          padding: new EdgeInsets.all(8.0),
                          itemBuilder: (BuildContext context, int index) {
                            return new Container(
                              margin:
                                new EdgeInsets.only(top: 10.0),

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
                                            timeago.format(DateTime.parse(
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

                                              Navigator.of(context).push(
                                                new PageRouteBuilder(

                                                  pageBuilder: (_, __, ___) => new WebviewScaffold(
                                                    url: data["articles"][index]["url"],
                                                    appBar: new AppBar(

                                                      centerTitle: true,
                                                      title: new Text("CryptoShadow", style:const TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 36.0),
                                                      ),
                                                      backgroundColor: Theme.Colors2.appBarGradientStart,
                                                    ),
                                                  ),
                                                  transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                                                  new FadeTransition(opacity: animation, child: child),
                                                ),
                                              );
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
                                "No articles",
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

}
