import 'package:alpha/view/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async{
  tz.initializeTimeZones();
  var detroit = tz.getLocation('Asia/Seoul');
  tz.setLocalLocation(detroit);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        unselectedWidgetColor: Colors.red,
        fontFamily: 'Pretendard'
      ),
      home: MainScreen()
      // home: Scaffold(
      //   appBar: AppBar(),
      //   body: Center(
      //     child: Column(
      //       children: [
      //         Image.asset('images/imgs/BadNoText.png'),
      //         Text('
      //         안녕하세요 헬로 월드 '),
      //         Text('안녕하세요 헬로 월드', style: TextStyle(
      //           fontWeight: FontWeight.w700
      //         ),),
      //         Image.asset('images/icons/BadNoText.png')
      //       ],
      //     ),
      //   ),
      // )
    );
  }
}

