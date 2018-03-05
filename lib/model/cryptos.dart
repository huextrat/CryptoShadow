import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Crypto {
  final String id;
  final String name;
  /**
  final String symbol;
  final String rank;
  final String currentPriceUSD;
  final String currentPriceBTC;
  final String percentChange1h;
  final String percentChange24h;
  final String percentChange7d;
   **/
  final String description;

  final String image;


  const Crypto({this.id, this.name, this.description, this.image});//, this.symbol, this.rank, this.currentPriceBTC, this.percentChange1h, this.percentChange7d, this.currentPriceUSD, this.percentChange24h,
  //this.description, this.image});

  static Future<List<Object>> getPrices({List<String> filter = const [], String currency = 'USD'}) async {
    String endpoint = 'https://api.coinmarketcap.com/v1/ticker/?convert=$currency';
    List<Object> list = JSON.decode((await http.get(endpoint)).body);
    if (filter.length == 0) {
      return list;
    } else {
      return list
          //.where((Object coin) => filter.indexOf(coin['symbol']) >= 0)
          .toList();
    }
  }
}

List<Crypto> cryptos = [

    const Crypto(
    id: "1",
    name: "Bitcoin",
    /**
    currentPriceUSD: "\$11 160,90",
    percentChange24h: "-2,72%",**/
    description: "Bitcoin",
    image: "assets/img/btc.png",
  ),
  const Crypto(
    id: "2",
    name: "Ethereum",
/**
    currentPriceUSD: "\$854,44",
    percentChange24h: "-0,74%",**/
    description: "Ethereum",
    image: "assets/img/eth.png",
  ),
  const Crypto(
    id: "3",
    name: "Golem",
/**
    currentPriceUSD: "\$0,425266",
    percentChange24h: "+0,34%",**/
    description: "Golem",
    image: "assets/img/gnt.png",
  ),
];