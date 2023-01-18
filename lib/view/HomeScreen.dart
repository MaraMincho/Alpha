import 'package:alpha/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'batchpill.dart';
import 'datailpillbatch.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 45,),
              GestureDetector(
                  onTap: (){
                    Get.to(DetailBatchPill());
                  },
                  child: ProfileViewer()),
              SizedBox(height: 65,),
              Expanded(
                child: ListView(
                  children: [
                    Text('오늘 먹을 알약', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                    BatchPills(),
                    BatchPills(),
                    BatchPills(),
                  ],
                ).animate(
                  delay: 400.ms, // this delay only happens once at the very start
                ).fadeIn(delay: 500.ms),
              )
            ],
          ),
        ),
      ),
    );
  }
}
