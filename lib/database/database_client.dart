import 'dart:async';
import 'dart:io';
import 'package:crypto_shadow/model/fiat.dart';
import 'package:crypto_shadow/model/portfolio.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseClient {
  Database _db;

  Future create() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "portfolio.db");
    _db = await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE portfolio (id INTEGER PRIMARY KEY AUTOINCREMENT, symbol TEXT, priceUSD TEXT, amount TEXT)');
    });
  }

  Future<int> deletePortfolio(int portfolio) async {
    int res = await _db.delete("portfolio", where: 'id = ?', whereArgs: [portfolio]);
    return res;
  }

  Future insertPortfolio(Portfolio portfolio) async {
    portfolio.id = await _db.insert("portfolio", portfolio.toMap());
    return portfolio;
  }

  Future fetchPortfolio() async {
    List results = await _db.query("portfolio", columns: Portfolio.columns);
    List portfolio = new List();
    results.forEach((map) {
      portfolio.add(Portfolio.fromMap(map));
    });
    return portfolio;
  }

  Future createFIAT() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "fiat.db");
    _db = await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE fiat (id INTEGER PRIMARY KEY AUTOINCREMENT, symbol TEXT)');
    });
  }

  Future<int> deleteFiat() async {
    int res = await _db.delete("fiat");
    return res;
  }

  Future insertFIAT(Fiat fiat) async {
    fiat.id = await _db.insert("fiat", fiat.toMap());
    return fiat;
  }

  Future fetchFIAT() async {
    List results = await _db.query("fiat", columns: Fiat.columns);
    List fiat = new List();
    results.forEach((map) {
      fiat.add(Fiat.fromMap(map));
    });
    return fiat;
  }

  Future close() async {
    await _db.close();
  }
}