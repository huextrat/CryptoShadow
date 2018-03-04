class Crypto {
  final String id;
  final String name;
  final String currentPrice;
  final String last24;
  final String description;
  final String image;


  const Crypto({this.id, this.name, this.currentPrice, this.last24,
    this.description, this.image});
}

List<Crypto> cryptos = [
  const Crypto(
    id: "1",
    name: "Bitcoin",
    currentPrice: "\$11 160,90",
    last24: "-2,72%",
    description: "Bitcoin",
    image: "assets/img/btc.png",
  ),
  const Crypto(
    id: "2",
    name: "Ethereum",
    currentPrice: "\$854,44",
    last24: "-0,74%",
    description: "Ethereum",
    image: "assets/img/eth.png",
  ),
  const Crypto(
    id: "3",
    name: "Golem",
    currentPrice: "\$0,425266",
    last24: "+0,34%",
    description: "Golem",
    image: "assets/img/gnt.png",
  ),
];