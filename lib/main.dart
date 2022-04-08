import 'package:flutter/material.dart';
import 'package:flutter_application_1/overview_screen.dart';
import 'package:flutter_application_1/places_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)),
      initialRoute: '/',
      routes: {
        '/': (context) => const OverviewScreen(),
        '/places': (context) => const PlacesScreen(),
      },
    );
  }
}
