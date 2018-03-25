class Portfolio {
  Portfolio();
  int id;
  String symbol;
  String priceUSD;
  String amount;

  static final columns = ["id", "symbol", "priceUSD", "amount"];

  Map toMap() {
    Map map = {
      "symbol": symbol,
      "priceUSD": priceUSD,
      "amount": amount,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  static fromMap(Map map) {
    Portfolio portfolio = new Portfolio();
    portfolio.id = map["id"];
    portfolio.symbol = map["symbol"];
    portfolio.priceUSD = map["priceUSD"];
    portfolio.amount = map["amount"];
    return portfolio;
  }

  String toString() {
    return "$id $symbol $priceUSD $amount";
  }
}