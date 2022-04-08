import 'package:flutter_application_1/place.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Storage {
  Database? database;

  Storage() {
    _loadDatabase();
  }

  Future<void> _loadDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'route-planner.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places(id STRING PRIMARY KEY, desc TEXT, lat FLOAT, lng FLOAT)',
        );
      },
      version: 1,
    );
  }

  Future<void> add(Place place) async {
    if (database == null) await _loadDatabase();
    database!.insert('places', place.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
