import 'package:alpha/view/HomeScreen.dart';
import 'package:alpha/view/detailpill.dart';
import 'package:alpha/view/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPill extends StatefulWidget {
  const AddPill({Key? key}) : super(key: key);

  @override
  State<AddPill> createState() => _AddPillState();
}

class _AddPillState extends State<AddPill> {
  final List<bool> _selectedFruits = <bool>[true, false, false];

  List<Widget> dateTime = <Widget>[
    Text('아침'),
    Text('점심'),
    Text('저녁')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(

        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            floating: false,
            pinned: true,
            snap: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(230),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("알약을 추가하세요", style: TextStyle(fontSize: 30),),
                  SizedBox(height: 14,),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _selectedFruits.length; i++) {
                          _selectedFruits[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedColor: Colors.white,
                    fillColor: Colors.blueAccent,
                    color: Colors.black,
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: _selectedFruits,
                    children: dateTime,
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18
                        ),
                        prefixIcon: Container(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.search),
                          width: 5,
                        )
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                alignment: Alignment.center,
                                title: Text("이 알약이 맞습니까?"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset("images/imgs/tylenol.png"),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("알약 이름 : "),
                                        Text("타이레놀"),
                                      ],
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('다시고르기',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                    },
                                  ),
                                  TextButton(
                                    child: Text('네 맞습니다!',
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                                    ),
                                    onPressed: () {
                                      Get.offAll(MainScreen());
                                    },
                                  ),
                                ],
                              );
                          }
                        );
                      },
                      child: Text("클릭하여 알약 추가하기", style: TextStyle(fontSize: 15),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 30, 13, 0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    DetailPill(),
                  ],
                )
              ),
            ),
          ]))
        ],
      ),
    );
  }
}

