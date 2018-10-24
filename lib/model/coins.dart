class Coins {
  String id;
  String symbol;
  double buyPriceUSD;
  double amount;

  Coins(String id, String symbol, double buyPriceUSD, double amount){
    this.id = id;
    this.symbol = symbol;
    this.buyPriceUSD = buyPriceUSD;
    this.amount = amount;
  }

  static final columns = ["id", "symbol", "buyPriceUSD", "amount"];

  Map toMap() {
    Map map = {
      "symbol": symbol,
      "buyPriceUSD": buyPriceUSD,
      "amount": amount,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  String toString() {
    return "$id $symbol $buyPriceUSD $amount";
  }
}