import 'package:alpha/view/datailpillbatch.dart';
import 'package:alpha/viewModel/TestController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchPills extends StatefulWidget {
  BatchPills({Key? key, required this.timeOfWidget}) : super(key: key);
  final String timeOfWidget;
  @override
  State<BatchPills> createState() => _BatchPillsState();
}

class _BatchPillsState extends State<BatchPills> {
  @override
  Widget build(BuildContext context) {
    var testController = Get.put(TestController());
    bool _ischecked = false;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.timeOfWidget}",
              style: TextStyle(
                fontSize: 25,
                letterSpacing: -1.5
            ),),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(-4, 4),
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('복용시 체크 ', style: TextStyle(color: Colors.red, fontSize: 18),),
                        Checkbox(
                            checkColor: Colors.red,
                            activeColor: Colors.amberAccent,
                          value: testController.check,
                          onChanged: (val) {
                          testController.check = val!;
                          print(testController.check);
                          setState(() {
                            print(testController.check);
                          });
                      })
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                                child: Text('타이레놀')),
                            Image.asset('images/imgs/tylenol.png', width: 100, height: 100,)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('타이레놀')),
                            Image.asset('images/imgs/tylenol.png', width: 100, height: 100,)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('타이레놀')),
                            Image.asset('images/imgs/tylenol.png', width: 100, height: 100,)
                          ],
                        ),
                      ),
                    ],
                  ),

                  InkWell(
                    onTap: () {
                      Get.to(DetailBatchPill());
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 30, 15),
                      child: Text('자세히 보기'),
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
