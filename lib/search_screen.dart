import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/secrets.dart';
import 'dart:convert';
import 'package:flutter_application_1/models/prediction.dart';
import 'package:flutter_application_1/prediction_list_tile.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchFieldController = TextEditingController();
  String content = "Nothing";
  final uuid = const Uuid();
  String? _sessionToken;

  void _onSearchFieldChanged(String input) {
    print('Search field changed: $input');
    setState(() {});
  }

  /// Fetches autocomplete predictions from the Google Places API based on the content of the search field.
  Future<List<Prediction>> fetchPredictions() async {
    String searchInput = searchFieldController.text;
    // Don't create a new session when the search is empty.
    // E.g. the user presses the back button without searching anything this would waste a billed request.
    if (searchInput.isNotEmpty) {
      String url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&sessiontoken=$_sessionToken&key=$googleApiKey";
      http.Response result = await http.get(Uri.parse(url));
      List<dynamic> predictionsJson = jsonDecode(result.body)['predictions'];
      List<Prediction> predictions = [];
      for (var element in predictionsJson) {
        predictions.add(Prediction.fromJson(element));
      }
      return predictions;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();

    // Generate a new session token. The same session token is used for all autocomplete requests. It is valid until the user picks a
    // place and a Place Details Request for this place is made. Usage of the session key leads to all autocomplete requests beeing billed by Google
    // as if it was only a single request. Otherwise every single request would be billed.
    _sessionToken = uuid.v4();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchFieldController,
          onChanged: _onSearchFieldChanged,
          decoration: const InputDecoration(
              hintText: 'Enter location name or address',
              hintStyle: TextStyle(color: Color.fromARGB(255, 201, 201, 201))),
          style: const TextStyle(color: Colors.white),
          autofocus: true,
        ),
      ),
      body: FutureBuilder(
        future: fetchPredictions(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Prediction>> snapshot) {
          try {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int i) {
                  return PredictionListTile(
                    prediction: snapshot.data![i],
                    onPredictionSelected: () => Navigator.pop(context),
                    onPredictionInserted: (Prediction p) {
                      searchFieldController.text = p.description;
                    },
                  );
                },
              );
            }
            // By default return loading icon
            return const Center(
              child: CircularProgressIndicator(),
            );
          } catch (e) {
            return const Center(
              child: Text('An error occurred.'),
            );
          }
        },
      ),
    );
  }
}
