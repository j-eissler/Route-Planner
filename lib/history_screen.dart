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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Place p = snapshot.data![index];
                return ExpansionTile(
                  // Specifying a key fixed the problem where after removing an expanded tile the next item on the list
                  // would be expanded after rebuilding the widget.
                  key: UniqueKey(),
                  title: Text(snapshot.data![index].descriptionNoCountry()),
                  initiallyExpanded: false,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              storage.setVisited(p, false);
                            });
                          },
                          icon: const Icon(Icons.flag),
                          label: const Text('Not Visited'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              storage.delete(p);
                            });
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                        ),
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
