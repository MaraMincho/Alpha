import 'package:alpha/view/batchpill.dart';
import 'package:alpha/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();

}


class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 45, 25, 0),
          child: Column(
            children: [
              ProfileViewer(),
              SizedBox(height: 65,),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Text('오늘 먹을 알약', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                    BatchPills(),
                    BatchPills(),
                    BatchPills(),
                  ],
                ),
              ).animate(
                delay: 400.ms, // this delay only happens once at the very start
              ).fadeIn(delay: 500.ms)
            ],
          ),
        ),
      ),
    );
  }
}
