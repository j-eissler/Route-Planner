import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/place.dart';
import 'package:flutter_application_1/models/storage.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  Storage storage = Storage();

  void refresh() {
    setState(() {});
  }

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
                            icon: Icon(Icons.check),
                            label: Text('Visited')),
                        ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.navigation),
                            label: Text('Go Here')),
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
