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
  int _selectedNavbarItem = 0;
  final pages = [
    OverviewMap(),
    Container(),
  ];

  Widget _pageBody = Container();
  Widget _appBarIcon = Icon(Icons.search);
  TextEditingController searchFieldController = TextEditingController();

  void _onNavbarTapped(int index) {
    setState(() {
      print("Tapped navbar item " + index.toString());
      _selectedNavbarItem = index;
    });
  }

  void _setMapMode() {
    // Remove focus from search field
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _pageBody = OverviewMap();
      _appBarIcon = Icon(Icons.search);
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
        icon: Icon(Icons.arrow_back),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // Create map and set icon like in _setMapMode. Calling _setMapMode doesn't work because
    // setState can't be called from initState. The widget was not yet inserted into the widget tree
    // and therefore has no state yet.
    _pageBody = OverviewMap();
    _appBarIcon = Icon(Icons.search);
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
        body: _pageBody, //pages[_selectedNavbarItem],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedNavbarItem,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.place),
              label: 'Addresses',
            ),
          ],
          onTap: _onNavbarTapped,
        ),
        /*floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => print("First Button"),
              child: const Icon(
                Icons.gps_fixed,
              ),
            ),
            FloatingActionButton(
              onPressed: () => print("Second Button"),
              child: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),*/
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
            );
          },
          child: Text('Go to first page'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'First Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: 'Second Item',
          ),
        ],
      ),
    );
  }
}
