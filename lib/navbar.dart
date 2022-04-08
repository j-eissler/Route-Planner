import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;
  const Navbar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/places');
            break;
          default:
        }
      },
      currentIndex: currentIndex,
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
    );
  }
}
