import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/place.dart';
import 'package:flutter_application_1/search_screen.dart';
import 'package:flutter_application_1/models/storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
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
    return Scaffold(
      appBar: AppBar(
          title: TextButton(
            // Button that creates the illusion of a search field. When pressed it moves the user to the search screen.
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search address',
              ),
              enabled: false,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
              // Reload page when coming back to it
            ).then((_) => setState(() {})),
          ),
          backgroundColor: Colors.white),
      body: FutureBuilder(
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
              initialCameraPosition: _cameraInitPos,
              markers: snapshot.data!,
              mapToolbarEnabled: false,
            );
          }

          // Markers being loaded, display loading icon
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
