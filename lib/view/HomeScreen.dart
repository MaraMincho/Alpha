import 'package:alpha/model/notificaon.dart';
import 'package:alpha/view/AddPill.dart';
import 'package:alpha/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;


import 'batchpill.dart';
import 'datailpillbatch.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    LocalNotification.initialize();
    LocalNotification.requestPermission();
  }
  @override
  Widget build(BuildContext context) {

    bool _isChecked = false;
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async{
                      print(tz.TZDateTime.now(tz.local));
                      await LocalNotification.instance.scheduleMorningAlram();

                    },
                      child: Text(
                        '오늘 먹을 알약',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
                  ),
                  IconButton(onPressed: (){
                    Get.to(AddPill());
                  },
                      icon: Icon(Icons.add, size: 30,))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Column(
                children: [
                  BatchPills(timeOfWidget: "아침식사 전후"),
                  //BatchPills(timeOfWidget: "점심식사 전후",),
                  //BatchPills(timeOfWidget: "저녁식사 전후",),
                  //BatchPills(),
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
