class Fiat {
  Fiat();
  int id;
  String symbol;

  static final columns = ["id", "symbol"];

  Map toMap() {
    Map map = {
      "symbol": symbol,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  static fromMap(Map map) {
    Fiat portfolio = new Fiat();
    portfolio.id = map["id"];
    portfolio.symbol = map["symbol"];
    return portfolio;
  }

  String toString() {
    return "$symbol";
  }
}