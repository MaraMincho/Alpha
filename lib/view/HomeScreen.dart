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
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            floating: false,
            pinned: true,
            snap: false,
            shadowColor: Colors.white.withOpacity(0),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(150),
              child: GestureDetector(
                  onTap: (){
                    Get.to(DetailBatchPill());
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: ProfileViewer(),
                  )),
            ),
          ),
          SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
              child: Text('오늘 먹을 알약', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Column(
                children: [
                  BatchPills(),
                  BatchPills(),
                  BatchPills(),
                ],
              ),
            ).animate()
                .fadeIn(delay: 300.ms, duration: 500.ms),
          ])
          ),
        ],
      )
    );
  }
}
