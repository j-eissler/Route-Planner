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
            // Keep the main page on the stack. This allows the user to always go back to the main
            // page by using the back button. Also it prevents closing the app by pressing the back
            // button.
            Navigator.pushNamedAndRemoveUntil(
                context, '/places', ModalRoute.withName('/'));
            break;
          case 2:
            Navigator.pushNamedAndRemoveUntil(
                context, '/history', ModalRoute.withName('/'));
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
        BottomNavigationBarItem(
          icon: currentIndex == 2
              ? const Icon(Icons.history)
              : const Icon(Icons.history_outlined),
          label: 'History',
        ),
      ],
    );
  }
}
