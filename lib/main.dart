import 'package:flutter/material.dart';
import 'package:flutter_application_1/address_predictions_list.dart';
import 'overview_map.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _pageBody = Container();
  Widget _appBarIcon = const Icon(Icons.search);
  TextEditingController searchFieldController = TextEditingController();
  int _selectedNavbarItem = 0;

  void _setMapMode() {
    // Remove focus from search field
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _pageBody = const OverviewMap();
      _appBarIcon = const Icon(Icons.search);
      searchFieldController.clear();
    });
  }

  void _setSearchMode() {
    setState(() {
      _pageBody = AddressPredictionsList(
        searchFieldController: searchFieldController,
        onPredictionSelected: _setMapMode,
      );
      _appBarIcon = IconButton(
        onPressed: _setMapMode,
        icon: const Icon(Icons.arrow_back),
      );
    });
  }

  void _onNavbarTapped(int index) {
    setState(() {
      _selectedNavbarItem = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Create map and set icon like in _setMapMode. Calling _setMapMode doesn't work because
    // setState can't be called from initState. The widget was not yet inserted into the widget tree
    // and therefore has no state yet.
    _pageBody = const OverviewMap();
    _appBarIcon = const Icon(Icons.search);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: TextField(
              controller: searchFieldController,
              decoration: InputDecoration(
                prefixIcon: _appBarIcon,
                hintText: 'Search address',
              ),
              onTap: _setSearchMode,
            ),
            backgroundColor: Colors.white),
        body: _pageBody,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onNavbarTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.place_sharp),
              label: 'Overview',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Places',
            ),
          ],
        ),
      ),
    );
  }
}
