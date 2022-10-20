import 'package:flutter/material.dart';
import 'package:my_final/pages/home.dart';
import 'package:my_final/pages/skema.dart';
import 'package:my_final/pages/blank.dart';
import 'package:my_final/pages/auth/login.dart';
import 'package:my_final/pages/auth/waiting.dart';
import 'package:my_final/pages/activity/activity.dart';
import 'package:my_final/pages/activity/apl01.dart';

class MyMaster extends StatefulWidget {
  const MyMaster({super.key});

  @override
  State<MyMaster> createState() => _MyMasterState();
}

class _MyMasterState extends State<MyMaster> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    // ActivityPage(),
    // PostPage()
    MyLogin()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.widgets),
          //   label: 'Alur',
          // ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 14, 111, 16),
        onTap: _onItemTapped,
      ),
      
    );
  }
}
