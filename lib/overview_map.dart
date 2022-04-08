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

        // Markers being loaded, display map and overlay box
        return Stack(children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: _cameraInitPos,
          ),
          const Center(
            child: CircularProgressIndicator(),
            /*child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(blurRadius: 8),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 80,
              ),
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('Placing markers...'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),*/
          ),
        ]);
      },
    );
  }
}
