import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/place.dart';
import 'package:flutter_application_1/models/prediction.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth/secrets.dart';
import 'models/storage.dart';

class PredictionListTile extends StatelessWidget {
  final Prediction prediction;
  final VoidCallback onPredictionSelected;
  final Function(Prediction) onPredictionInserted;

  const PredictionListTile(
      {Key? key,
      required this.prediction,
      required this.onPredictionSelected,
      required this.onPredictionInserted})
      : super(key: key);

  /// Makes a request to the Google Geocoding API and finds information about the place
  /// with the previously determined place id.
  Future<Place?> _fetchPlaceInfo() async {
    try {
      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?place_id=${prediction.placeId}&key=$googleApiKey';
      http.Response result = await http.get(Uri.parse(url));
      final jsonResult = jsonDecode(result.body)['results'][0];
      String description = jsonResult['formatted_address'];
      LatLng latLng = LatLng(jsonResult['geometry']['location']['lat'],
          jsonResult['geometry']['location']['lng']);
      return Place(
          description: description,
          latLng: latLng,
          placeId: prediction.placeId);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(prediction.description),
      onTap: () async {
        // Fetch place information
        Place? place = await _fetchPlaceInfo();
        if (place == null) return;

        // Add place to database
        Storage storage = Storage();
        await storage.add(place);

        // Go back to map page
        onPredictionSelected();
      },
      trailing: IconButton(
        icon: const Icon(Icons.north_west),
        onPressed: () => onPredictionInserted(prediction),
      ),
    );
  }
}
