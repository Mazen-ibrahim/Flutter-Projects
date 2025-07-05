import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/models/place.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

Future<sql.Database> _getDataBase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'place.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY , title TEXT , image TEXT , lat REAL , lng REAL , address TEXT)');
    },
    version: 1,
  );
  return db;
}

class PlaceState extends StateNotifier<List<Place>> {
  PlaceState() : super([]);

  Future<void> loadPlaces() async {
    final sql.Database db = await _getDataBase();
    final List<Map<String, Object?>> data = await db.query('user_places');
    final List<Place> places = data
        .map((row) => Place(
            id : row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
                longitude: row['lng'] as double,
                latitude: row['lat'] as double,
                address: row['address'] as String)))
        .toList();

    state = places;
  }

  void addPlace(Place place) async {
    final Directory appDir = await syspaths.getApplicationDocumentsDirectory();
    final imageName = path.basename(place.image.path);
    final copiedimage = await place.image.copy('${appDir.path}/$imageName');
    log(copiedimage.path);

    final db = await _getDataBase();

    db.insert('user_places', {
      'id': place.id,
      'title': place.title,
      'image': copiedimage.path,
      'lat': place.location.latitude,
      'lng': place.location.longitude,
      'address': place.location.address
    });

    state = [place, ...state];
  }

  void removePlace(Place place) {
    state = state.where((item) {
      return item != place;
    }).toList();
  }
}

final placeStateProvider =
    StateNotifierProvider<PlaceState, List<Place>>((ref) {
  return PlaceState();
});
