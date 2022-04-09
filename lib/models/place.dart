import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String description;
  final LatLng latLng;
  // Google Maps place Id. Stored for possible future requests
  final String placeId;
  bool visited;

  Place({
    required this.description,
    required this.latLng,
    required this.placeId,
    this.visited = false,
  });

  @override
  String toString() {
    return 'Desc: $description, LatLng: $latLng, PlaceID: $placeId, Visited: $visited';
  }

  // The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': placeId,
      'desc': description,
      'lat': latLng.latitude,
      'lng': latLng.longitude,
      'visited': visited,
    };
  }

  // Returns the description without the last colon and country name
  String descriptionNoCountry() {
    return description.substring(0, description.lastIndexOf(','));
  }
}
