import 'package:flutter_application_1/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Storage {
  Database? database;

  Storage() {
    _loadDatabase();
  }

  Future<void> _loadDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'route-planner.sqlite'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places(id STRING PRIMARY KEY, desc TEXT, lat FLOAT, lng FLOAT, visited INT)',
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

  Future<List<Place>> getAllUnvisitedPlaces() async {
    if (database == null) await _loadDatabase();
    final List<Map<String, dynamic>> maps =
        await database!.query('places', where: 'visited = ?', whereArgs: [0]);
    // Convert the List<Map<String, dynamic> into a List<Place>.
    return List.generate(maps.length, (i) {
      return Place(
          description: maps[i]['desc'],
          latLng: LatLng(maps[i]['lat'], maps[i]['lng']),
          placeId: maps[i]['id'],
          visited: maps[i]['visited'] == 0 ? false : true);
    });
  }

  Future<List<Place>> getAllVisitedPlaces() async {
    if (database == null) await _loadDatabase();
    final List<Map<String, dynamic>> maps =
        await database!.query('places', where: 'visited = ?', whereArgs: [1]);
    // Convert the List<Map<String, dynamic> into a List<Place>.
    return List.generate(maps.length, (i) {
      return Place(
          description: maps[i]['desc'],
          latLng: LatLng(maps[i]['lat'], maps[i]['lng']),
          placeId: maps[i]['id'],
          visited: maps[i]['visited'] == 0 ? false : true);
    });
  }

  void delete(Place place) async {
    if (database == null) await _loadDatabase();
    database!.delete('places', where: 'id = ?', whereArgs: [place.placeId]);
  }

  void markVisited(Place place) async {
    if (database == null) await _loadDatabase();
    place.visited = true;
    database!.update('places', place.toMap(),
        where: 'id = ?', whereArgs: [place.placeId]);
  }
}
