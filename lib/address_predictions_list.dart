import 'package:flutter/material.dart';
import 'package:flutter_application_1/prediction_list_tile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:flutter_application_1/prediction.dart';
import 'auth/secrets.dart';

class AddressPredictionsList extends StatefulWidget {
  final TextEditingController searchFieldController;

  const AddressPredictionsList({Key? key, required this.searchFieldController})
      : super(key: key);

  @override
  State<AddressPredictionsList> createState() => _AddressPredictionsListState();
}

class _AddressPredictionsListState extends State<AddressPredictionsList> {
  String content = "Nothing";
  final uuid = const Uuid();
  String? _sessionToken;

  void _onSearchFieldChanged() {
    setState(() {
      //content = widget.searchFieldController.text;
    });
  }

  /// Fetches autocomplete predictions from the Google Places API based on the content of the search field.
  Future<List<Prediction>> fetchPredictions() async {
    String searchInput = widget.searchFieldController.text;
    // Don't create a new session when the search is empty.
    // E.g. the user presses the back button without searching anything this would waste a billed request.
    if (searchInput.isNotEmpty) {
      String url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${searchInput}&sessiontoken=${_sessionToken}&key=${googleApiKey}";
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
    widget.searchFieldController.addListener(_onSearchFieldChanged);

    // Generate a new session token. The same session token is used for all autocomplete requests. It is valid until the user picks a
    // place and a Place Details Request for this place is made. Usage of the session key leads to all autocomplete requests beeing billed by Google
    // as if it was only a single request. Otherwise every single request would be billed.
    _sessionToken = uuid.v4();
  }

  @override
  void dispose() {
    super.dispose();
    widget.searchFieldController.removeListener(_onSearchFieldChanged);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPredictions(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Prediction>> snapshot) {
        try {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int i) {
                return PredictionListTile(prediction: snapshot.data![i]);
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
    );
  }
}
