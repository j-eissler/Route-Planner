import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  String description;
  LatLng latLng;
  // Google Maps place Id. Stored for possible future requests
  String placeId;

  Place(this.description, this.latLng, this.placeId);

  @override
  String toString() {
    return 'Desc: ${description}, LatLng: ${latLng}, PlaceID: ${placeId}';
  }

  // The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': placeId,
      'desc': description,
      'lat': latLng.latitude,
      'lng': latLng.longitude,
    };
  }
}
