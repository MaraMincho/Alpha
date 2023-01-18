import 'package:alpha/view/PillRecognation.dart';
import 'package:alpha/view/batchpill.dart';
import 'package:alpha/view/datailpillbatch.dart';
import 'package:alpha/view/profile.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 45, 25, 0),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Get.to(DetailBatchPill());
                },
                  child: ProfileViewer()),
              SizedBox(height: 65,),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Text('오늘 먹을 알약', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                    GestureDetector(
                      child: BatchPills(),
                      onTap: () {
                        Get.to(PillRecognation());
                      }
                    ),
                    BatchPills(),
                    BatchPills(),
                  ],
                ),
              ).animate(
                delay: 400.ms, // this delay only happens once at the very start
              ).fadeIn(delay: 500.ms)
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
