import 'package:intl/intl.dart';

class Crypto {
  String id;
  String name;
  String symbol;
  String rank;
  String priceUsd;
  String priceBtc;
  String volumeUsd;
  String marketCapUsd;
  String availableSupply;
  String totalSupply;
  String percentChange1h;
  String percentChange24h;
  String percentChange7d;
  String lastUpdated;
  String priceEur;
  String volumeEur;
  String marketCapEur;

  Crypto(this.id, this.name, this.symbol, this.rank, this.priceUsd, this.priceBtc,
      this.volumeUsd, this.marketCapUsd, this.availableSupply,
      this.totalSupply, this.percentChange1h, this.percentChange24h,
      this.percentChange7d, this.lastUpdated, this.priceEur, this.volumeEur, this.marketCapEur) {

    this.priceUsd = double.parse(this.priceUsd).toStringAsFixed(4);
    this.volumeUsd = double.parse(this.volumeUsd) >= 1000000 ? (double.parse(this.volumeUsd)/1000000).toStringAsFixed(2) : this.volumeUsd;

    if(this.percentChange1h!=null){
      this.percentChange1h = double.parse(this.percentChange1h).toStringAsFixed(1);
    }
    else {
      this.percentChange1h = double.parse("0.0").toStringAsFixed(1);
    }

    if(this.percentChange24h!=null){
      this.percentChange24h = double.parse(this.percentChange24h).toStringAsFixed(1);
    }
    else {
      this.percentChange24h = double.parse(this.percentChange1h).toStringAsFixed(1);
    }

    if(this.percentChange7d!=null){
      this.percentChange7d = double.parse(this.percentChange7d).toStringAsFixed(1);
    }
    else {
      this.percentChange7d = double.parse(this.percentChange24h).toStringAsFixed(1);
    }

    this.priceEur = double.parse(this.priceEur).toStringAsFixed(4);
    this.volumeEur = double.parse(this.volumeEur) >= 1000000 ? (double.parse(this.volumeEur)/1000000).toStringAsFixed(2) : this.volumeEur;
  }

  String formatCurrency(String amount) {
    final format = new NumberFormat("#,##0.0000", "en_US");
    return format.format(double.parse(amount));
  }

  String formatVolume(String amount) {
    final format = new NumberFormat("#,##0.00", "en_US");
    return format.format(double.parse(amount));
  }
}