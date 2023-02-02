import 'package:alpha/view/PillRecognation.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'Test.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const List<Widget> _screen = [
    HomeScreen(), PillRecognation(), Test()
  ];
  static int _currentScreenIndex = 2;


  void _onItemTapped(int index) {
    setState(() {
      _currentScreenIndex = index;
      print(_currentScreenIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: '알약 인식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pharmacy_rounded),
            label: '약국 어디',
          ),
        ],
        currentIndex: _currentScreenIndex,
        onTap: _onItemTapped,
        iconSize: MediaQuery.of(context).size.width * 0.08,
        unselectedFontSize: 13,
        selectedFontSize: 15,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black26,
      ),
        body: _screen.elementAt(_currentScreenIndex));

  }
}
