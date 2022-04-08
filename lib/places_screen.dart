import 'package:flutter/material.dart';
import 'package:flutter_application_1/navbar.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My places')),
      body: Text('...'),
      bottomNavigationBar: const Navbar(
        currentIndex: 1,
      ),
    );
  }
}
