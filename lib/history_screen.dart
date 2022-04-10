import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/place.dart';
import 'package:flutter_application_1/models/storage.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visited Places'),
      ),
      body: FutureBuilder(
        future: storage.getAllVisitedPlaces(),
        builder: (context, AsyncSnapshot<List<Place>> snapshot) {
          if (snapshot.hasData) {
            // show list of places
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(snapshot.data![index].descriptionNoCountry()),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          icon: Icon(Icons.flag),
                          onPressed: () {
                            setState(() {
                              storage.setVisited(snapshot.data![index], false);
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              storage.delete(snapshot.data![index]);
                            });
                          },
                        ),
                      ],
                    ));
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
      ),
    );
  }
}
