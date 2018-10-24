import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:crypto_shadow/model/cryptos.dart';
import 'package:crypto_shadow/ui/detail/crypto_summary.dart';


import 'package:http/http.dart' as http;
import 'package:crypto_shadow/theme.dart' as Theme;


class HomePageBody extends StatefulWidget {
  @override
  HomePageBodyState createState() => new HomePageBodyState();
}

class HomePageBodyState extends State<HomePageBody> {

  List data;
  bool isLoading = true;

  Future<bool> getDataFromAPI() async {

    var response = await http.get(
      Uri.encodeFull("https://api.coinmarketcap.com/v1/ticker/?convert="+"EUR"+"&limit=100"),
      headers: {
        "Accept": "application/json"
      },
    );

    this.setState(() {
      data = json.decode(response.body);
      isLoading = false;
    });
    String content = response.body;
    (await getLocalFile()).writeAsString('$content');

    return true;
  }

  Future<File> getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/coin_list.txt');
  }

  Future<bool> getDataFromLocal() async {
    try {
      File file = await getLocalFile();
      String contents = await file.readAsString();

      this.setState(() {
        data = json.decode(contents);
        isLoading = false;
      });

      return true;
    } on FileSystemException {
      return false;
    }
  }

  Future<bool> getData() async {
    if(!(await getDataFromLocal())) {
      await getDataFromAPI();
    }
    return true;
  }

  Future loadData() async {
    await getDataFromAPI();
    await getData();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Crypto getCoin(int index) {
    if(data != null){
      return new Crypto(
        data[index]["id"],
        data[index]["name"],
        data[index]["symbol"],
        data[index]["rank"],
        data[index]["price_usd"],
        data[index]["price_btc"],
        data[index]["24h_volume_usd"],
        data[index]["market_cap_usd"],
        data[index]["available_supply"],
        data[index]["total_supply"],
        data[index]["percent_change_1h"],
        data[index]["percent_change_24h"],
        data[index]["percent_change_7d"],
        data[index]["last_updated"],
        data[index]["price_eur"],
        data[index]["24h_volume_eur"],
        data[index]["market_cap_eur"],
      );
    }

  }

  Future refresh() async {
    await getDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Theme.Colors2.appBarGradientStart, Theme.Colors2.appBarGradientEnd],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp
          ),
        ),

        child: new RefreshIndicator(
          onRefresh: refresh,
          child: new CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            slivers: <Widget>[
              new SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),

                sliver: new SliverList(
                  delegate: data != null ? new SliverChildBuilderDelegate(
                        (context, index) => new CryptoSummary(getCoin(index)),
                    childCount: data==null ? 100 : data.length,
                  ) : new SliverChildBuilderDelegate(
                        (context, index) => new CircularProgressIndicator(),
                    childCount: 0,
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}