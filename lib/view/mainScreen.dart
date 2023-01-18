import 'package:alpha/view/HomeScreen.dart';
import 'package:alpha/view/PillRecognationScreen.dart';
import 'package:flutter/material.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const List<Widget> _screen = [
    HomeScreen(), PillRecognation(),
  ];
  static int _currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {

    void _onItemTapped(int index) {
      setState(() {
        _currentScreenIndex = index;
        print(_currentScreenIndex);
      });
    }
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
      body: _screen.elementAt(_currentScreenIndex)
    );
  }
}
