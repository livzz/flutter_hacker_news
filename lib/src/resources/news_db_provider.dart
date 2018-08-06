import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source,Cache {
  Database db;

  NewsDbProvider(){
    init();
  }

  void init() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    final path = join(docDir.path, "items.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
         CREATE TABLE items(
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            text TEXT,
            time INTEGER,
            score INTEGER,
            parent INTEGER,
            kids BLOG,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            title TEXT,
            descendants INTEGER
         )
        """);
      }
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if(maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) async {
    return await db.insert("items", item.toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // TODO: Store and fetch
  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }

}

final NewsDbProvider newsDbProvider = new NewsDbProvider();