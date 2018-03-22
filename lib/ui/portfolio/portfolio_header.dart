import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crypto_shadow/theme.dart' as Theme;

class PortfolioHeader extends StatelessWidget {

  final double total;
  final double stake;
  final String fiat;
  PortfolioHeader({this.total, this.stake, this.fiat});

  final TextStyle detailNumberStyle = new TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500);
  final TextStyle detailExp = new TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w200);

  @override
  Widget build(BuildContext ctx) {
    double profit = total - stake;
    NumberFormat nf = new NumberFormat("###,###,###");
    double percent = profit / total * 100;
    return new ClipPath(
      clipper: new ArcClipper(),
      child: new Container(
        width: 500.0,
        padding: const EdgeInsets.only(top: 50.0),
        decoration: new BoxDecoration(gradient: Theme.Colors2.primaryGradient),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    new Text(nf.format(total)+" $fiat", style: new TextStyle(color: Colors.white, fontSize: 38.0, fontWeight: FontWeight.w400)),
                    //new Text("TOTAL $fiat", style: new TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13.0))
                  ]
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    new Text('STAKE', style: detailExp),
                    new Text(nf.format(stake) + ' $fiat', style: detailNumberStyle),
                  ]),
                  new Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
                    new Text('PROFIT (${percent.toStringAsFixed(0)}%)', style: detailExp),
                    new Text(nf.format(profit) + ' $fiat', style: detailNumberStyle),
                  ]),
                ],
              )
            ]
        ),
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 15);

    var firstControlPoint = new Offset(size.width / 4, size.height);
    var firstPoint = new Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstPoint.dx, firstPoint.dy);
    var secondControlPoint =new Offset(size.width - (size.width / 4), size.height);
    var secondPoint = new Offset(size.width, size.height - 15);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondPoint.dx, secondPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}