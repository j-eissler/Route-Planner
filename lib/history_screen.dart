import 'package:flutter/material.dart';
import 'package:flutter_application_1/navbar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visited Places')),
      bottomNavigationBar: const Navbar(
        currentIndex: 2,
      ),
    );
  }
}
