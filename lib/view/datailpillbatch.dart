import 'package:alpha/view/batchpill.dart';
import 'package:alpha/view/detailpill.dart';
import 'package:alpha/view/webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailBatchPill extends StatelessWidget {
  const DetailBatchPill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 45, 25, 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {Get.back();},
                child: Container(
                  alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back,
                    size: 40,
                    )),
              ),
              Text('알약 클릭시',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, letterSpacing: -1),),
              Text('상세 정보를 클립합니다.', style: TextStyle(fontSize: 35),),
              SizedBox(height: 30,),
              Align(alignment: Alignment.topLeft,child: Text('아침식사 이전',style: TextStyle(fontSize: 25, letterSpacing: -1),)),


              Expanded(
                  child: ListView(
                    children: [
                      GestureDetector(
                          child: DetailPill(),
                        onTap: (){
                            Get.to(WebViewScreen());
                        },
                      ),
                      DetailPill(),
                      DetailPill(),
                      DetailPill(),
                    ],
                  )
              )
            ],
          ),
        ),
      )
    );
  }
}
