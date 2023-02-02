import 'package:alpha/viewModel/searchPill.dart';
import 'package:alpha/viewModel/sqlhelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  var testViewModel = Get.put(SearchPillViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async{
                    await testViewModel.getHome();
                  },
                  child: Text("GetHome")),
              ElevatedButton(
                  onPressed: () async{
                    await testViewModel.getPill();
                  },
                  child: Text("GetPill")),
              ElevatedButton(
                  onPressed: () async{
                    await DatabaseHelper.instance.insert();
                    var temp = await DatabaseHelper.instance.GetSomething();
                    print(temp);

                  },
                  child: Text("GetDB")),
              //Image.memory(Uint8List.fromList(testViewModel.currentPill.image!.data!)),
            ],
          )
        ),
      ),
    );
  }
}

class Temp extends StatelessWidget {
  const Temp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: Colors.black.withOpacity(0.3),),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: Image.asset('images/imgs/img.png'),
                    ),
                  )
              ),
              Expanded(flex: 5, child: SizedBox()),
              Expanded(
                flex: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text('정다함')),
                          Expanded(
                              flex: 12,
                              child: Text('2023-01-19', style: TextStyle(color: Colors.black.withOpacity(0.6)),))
                        ],
                      ),
                      Text('''얼마나 많은 세월이 흘러야 잊혀지려나
지금 여기 너 떠난 후에 나는 이렇게 쓸쓸한데

모두들 얘기를 하지 세월이 약이 될거라
지금 여기 너 떠난 후에 나는 이렇게 쓸쓸한데

다시 한번 내 가슴에 널 안을 수 있다면
너의 작은 심장이 두근대는 그 소리를

다시 들을 수도 없고 다시 안을 수도 없고
다만 눈물로 묻어둘 밖에 안녕 잘 가라 내 사랑



다시 한번 내 가슴에 널 안을 수 있다면
너의 작은 심장이 두근대는 그 소리를

다시 들을 수도 없고 다시 안을 수도 없고
다만 눈물로 묻어둘 밖에 안녕 잘 가라 내 사랑

얼마나 많은 세월이 흘러야 잊혀지려나
지금 여기 너 떠난 후에 나는 이렇게 쓸쓸한데
                                ''')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
