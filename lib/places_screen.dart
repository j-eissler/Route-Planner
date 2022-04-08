import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/place.dart';
import 'package:flutter_application_1/models/storage.dart';
import 'package:flutter_application_1/navbar.dart';

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
      appBar: AppBar(title: Text('My places')),
      body: FutureBuilder(
        future: storage.getAllPlaces(),
        builder: (context, AsyncSnapshot<List<Place>> snapshot) {
          if (snapshot.hasData) {
            // show list of places
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].description),
                  );
                });
          }

          // Places being loaded, display loading icon
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: const Navbar(
        currentIndex: 1,
      ),
    );
  }
}
