import 'package:flutter/material.dart';
import 'package:flutter_application_1/history_screen.dart';
import 'package:flutter_application_1/overview_screen.dart';
import 'package:flutter_application_1/places_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentNavbarIndex = 0;

  @override
  Widget build(BuildContext context) {
    const List<Widget> _screens = <Widget>[
      OverviewScreen(),
      PlacesScreen(),
      HistoryScreen(),
    ];

    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)),
      home: Scaffold(
        body: _screens[_currentNavbarIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _currentNavbarIndex = index;
            });
          },
          currentIndex: _currentNavbarIndex,
          items: [
            BottomNavigationBarItem(
              icon: _currentNavbarIndex == 0
                  ? const Icon(Icons.place)
                  : const Icon(Icons.place_outlined),
              label: 'Overview',
            ),
            BottomNavigationBarItem(
              icon: _currentNavbarIndex == 1
                  ? const Icon(Icons.bookmark)
                  : const Icon(Icons.bookmark_outline),
              label: 'Places',
            ),
            BottomNavigationBarItem(
              icon: _currentNavbarIndex == 2
                  ? const Icon(Icons.history)
                  : const Icon(Icons.history_outlined),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}
