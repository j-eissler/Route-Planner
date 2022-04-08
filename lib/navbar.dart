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
      items: [
        BottomNavigationBarItem(
          icon: currentIndex == 0
              ? const Icon(Icons.place)
              : const Icon(Icons.place_outlined),
          label: 'Overview',
        ),
        BottomNavigationBarItem(
          icon: currentIndex == 1
              ? const Icon(Icons.bookmark)
              : const Icon(Icons.bookmark_outline),
          label: 'Places',
        ),
      ],
    );
  }
}
