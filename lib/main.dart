import 'package:alpha/view/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Pretendard'
      ),
      home: MainScreen()
      // home: Scaffold(
      //   appBar: AppBar(),
      //   body: Center(
      //     child: Column(
      //       children: [
      //         Image.asset('images/imgs/img.png'),
      //         Text('안녕하세요 헬로 월드 '),
      //         Text('안녕하세요 헬로 월드', style: TextStyle(
      //           fontWeight: FontWeight.w700
      //         ),),
      //         Image.asset('images/icons/img.png')
      //       ],
      //     ),
      //   ),
      // )
    );
  }
}

