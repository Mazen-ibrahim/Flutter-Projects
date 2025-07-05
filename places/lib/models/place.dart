import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double longitude;
  final double latitude;
  final String address;

  PlaceLocation(
      {required this.longitude, required this.latitude, required this.address});
}

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  Place(
      {String? id,
      required this.title,
      required this.image,
      required this.location})
      : id = id ?? uuid.v4();
}
