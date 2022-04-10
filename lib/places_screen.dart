import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/place.dart';
import 'package:flutter_application_1/models/storage.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Places'),
      ),
      body: FutureBuilder(
        future: storage.getAllUnvisitedPlaces(),
        builder: (context, AsyncSnapshot<List<Place>> snapshot) {
          if (snapshot.hasData) {
            // show list of places
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Place p = snapshot.data![index];
                return ExpansionTile(
                  title: Text(p.description),
                  initiallyExpanded: false,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                storage.setVisited(p, true);
                              });
                            },
                            icon: const Icon(Icons.check),
                            label: const Text('Visited')),
                        ElevatedButton.icon(
                            onPressed: () {
                              launch(
                                  'https://www.google.com/maps/search/?api=1&query=${p.latLng.latitude},${p.latLng.longitude}&query_place_id=${p.placeId}');
                            },
                            icon: const Icon(Icons.navigation),
                            label: const Text('Go Here')),
                      ],
                    )
                  ],
                );
              },
            );
          }

          // Places being loaded, display loading icon
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
