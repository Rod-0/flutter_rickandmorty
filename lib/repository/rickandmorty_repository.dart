import 'package:flutter_rickandmorty/database/rickandmorty_database.dart';
import 'package:flutter_rickandmorty/models/rickandmorty.dart';

import 'package:sqflite/sqflite.dart';

class RickAndMortyRepository {
  Future insert(RickAndMorty rickAndMorty) async {
    Database db = await RickAndMortyDatabase().openDb();
    db.insert(RickAndMortyDatabase().tableName, rickAndMorty.toMap());
  }

  Future delete(RickAndMorty rickAndMorty) async {
    Database db = await RickAndMortyDatabase().openDb();
    db.delete(RickAndMortyDatabase().tableName,
        where: "id = ?", whereArgs: [rickAndMorty.id]);
  }

  Future<bool> isFavorite(RickAndMorty rickAndMorty) async {
    Database db = await RickAndMortyDatabase().openDb();
    final maps = await db.query(RickAndMortyDatabase().tableName,
        where: "id=?", whereArgs: [rickAndMorty.id]);
    return maps.isNotEmpty;
  }

  Future <List<RickAndMorty>> getAll() async{
    Database db = await RickAndMortyDatabase().openDb();
    final maps = await db.query(RickAndMortyDatabase().tableName);
    return maps.map((map) => RickAndMorty.fromMap(map)).toList();
  }
}
