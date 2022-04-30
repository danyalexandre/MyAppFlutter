import 'package:flutter/material.dart';

class MyBottomNavigation extends StatefulWidget {
  int selectedIndex;

  MyBottomNavigation({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xff191720),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.blueGrey,
      currentIndex: widget.selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Créer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_sharp),
          label: 'Profile',
        )
      ],
    );
  }
}
