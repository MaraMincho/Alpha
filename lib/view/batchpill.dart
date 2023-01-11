import 'package:flutter/material.dart';


class BatchPills extends StatelessWidget {
  const BatchPills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('아침식사 이전',
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
                  SizedBox(height: 15,),
                  Text('복용시 체크   ', style: TextStyle(color: Colors.red, fontSize: 18),),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                                child: Text('안녕세요')),
                            Image.asset('images/icons/img.png', width: 100, height: 100,)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('안녕세요')),
                            Image.asset('images/icons/img.png', width: 100, height: 100,)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('안녕세요')),
                            Image.asset('images/icons/img.png', width: 100, height: 100,)
                          ],
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
