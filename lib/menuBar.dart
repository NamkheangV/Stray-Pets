import 'package:flutter/material.dart';
import 'package:stray_pet/pages/homePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stray_pet/pages/profilePage.dart';

class MyMenu extends StatefulWidget {
  final String userId;

  const MyMenu({super.key, required this.userId});

  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  late String _userId;

  @override
  void initState() {
    super.initState();
    _userId = widget.userId;
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttonAction = [
      HomePage(
        userId: _userId,
      ),
      ProfilePage(
        userId: _userId,
      ),
    ];

    return Scaffold(
      body: buttonAction[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 90, 163, 223),
          selectedItemColor: Colors.white,
          selectedLabelStyle: GoogleFonts.notoSans(),
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ]),
    );
  }
}
