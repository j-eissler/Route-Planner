import 'package:flutter/material.dart';
import 'package:flutter_application_1/place.dart';
import 'package:flutter_application_1/storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OverviewMap extends StatefulWidget {
  const OverviewMap({Key? key}) : super(key: key);

  @override
  State<OverviewMap> createState() => _OverviewMapState();
}

class _OverviewMapState extends State<OverviewMap> {
  late GoogleMapController mapController;
  final CameraPosition _cameraInitPos = const CameraPosition(
    target: LatLng(50.775555, 6.083611),
    zoom: 11.0,
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Set<Marker>> _generateMarkers() async {
    Storage storage = Storage();
    List<Place> places = await storage.getAllPlaces();

    Set<Marker> markers = {};
    for (Place p in places) {
      markers.add(
        Marker(markerId: MarkerId(p.placeId), position: p.latLng),
      );
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _generateMarkers(),
      builder: (context, AsyncSnapshot<Set<Marker>> snapshot) {
        if (snapshot.hasData) {
          // Markers were generated, display map
          return GoogleMap(
            onMapCreated: _onMapCreated,
            compassEnabled: true,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: true,
            initialCameraPosition: _cameraInitPos,
            markers: snapshot.data!,
          );
        }

        // Markers being loaded, display loading icon
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
