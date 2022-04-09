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
    return FutureBuilder(
      future: storage.getAllPlaces(),
      builder: (context, AsyncSnapshot<List<Place>> snapshot) {
        if (snapshot.hasData) {
          // show list of places
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].descriptionNoCountry()),
                trailing: IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    setState(() {
                      // TODO: Change delete to "mark as visited"
                      storage.markVisited(snapshot.data![index]);
                    });
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
        }

        // Places being loaded, display loading icon
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
