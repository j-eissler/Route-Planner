import 'package:flutter/material.dart';
import 'package:flutter_application_1/overview_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedNavbarItem = 0;

  void _onNavbarTapped(int index) {
    setState(() {
      _selectedNavbarItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: OverviewScreen(),
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
