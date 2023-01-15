
import 'package:flutter/material.dart';

class PillRecognation extends StatefulWidget {
  const PillRecognation({Key? key}) : super(key: key);

  @override
  State<PillRecognation> createState() => _PillRecognationState();
}

class _PillRecognationState extends State<PillRecognation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 60, 25, 0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("알약을 찍어주세요!",
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700, letterSpacing: -1)),
                  SizedBox(height: 5,),
                  Text("다음의 것들을 주의해야 합니다!",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: -1.5, color: Colors.red)),
                  SizedBox(height: 10,),
                  GoodAndBadImageDescription(
                      titleText: '배경 이미지를 안보이게 찍어주세요',
                      goodImageDescription: '잘찍었음',
                      badImageDescription: '못 찍었음',
                      goodImageUrl: 'images/imgs/AIRecognationIdealPhotoGuide/idealNoText.png',
                      badImageUrl: 'images/imgs/AIRecognationIdealPhotoGuide/BadNoText.png'),
                  GoodAndBadImageDescription(
                      titleText: '배경 이미지를 안보이게 찍어주세요',
                      goodImageDescription: '잘찍었음',
                      badImageDescription: '못 찍었음',
                      goodImageUrl: 'images/imgs/AIRecognationIdealPhotoGuide/idealNoZoom.png',
                      badImageUrl: 'images/imgs/AIRecognationIdealPhotoGuide/BadNoZoom.png'),

                  SizedBox(
                    width: MediaQuery.of(context).size.width* 0.7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Icon( // <-- Icon
                                Icons.folder,
                                size: 45.0,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                              ),
                            ),
                            Expanded(
                              flex: 8,
                                child: Container(
                                  alignment: Alignment.center,
                                    child: Text('앨범에서 가져오기', style: TextStyle(fontSize: 23, letterSpacing: -1),))), // <-- Text
                          ],
                        )),
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width* 0.7,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Icon( // <-- Icon
                                Icons.camera_alt,
                                size: 45.0,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                              ),
                            ),
                            Expanded(
                                flex: 8,
                                child: Container(
                                  alignment: Alignment.center,
                                    child: Text('카메라로 찍기', style: TextStyle(fontSize: 23, letterSpacing: -1),))), // <-- Text
                          ],
                        )),
                  ),
                ]

            ),
          ),
        ),
      ),
    );
  }
}

class GoodAndBadImageDescription extends StatelessWidget {
  final String goodImageUrl;
  final String goodImageDescription;
  final String badImageUrl;
  final String badImageDescription;
  final String titleText;
  GoodAndBadImageDescription({Key? key,
    required this.titleText,
    required this.goodImageDescription,
    required this.badImageDescription,
    required this.goodImageUrl,
    required this.badImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
      child: Column(
        children: [
          Text("${titleText}", style: TextStyle(fontSize: 20, letterSpacing: -1),),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                        width:150,
                        height: 150,
                        child: Image.asset('$badImageUrl', fit: BoxFit.fitWidth,)),

                    SizedBox(height: 10,),
                    Text('$badImageDescription', style: TextStyle(fontSize: 18, letterSpacing: -1, color: Colors.indigo),)
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                        width:150,
                        height: 150,
                        child: Image.asset('$goodImageUrl', fit: BoxFit.fitWidth,)),
                    SizedBox(height: 10,),
                    Text('$goodImageDescription', style: TextStyle(fontSize: 18, letterSpacing: -1, color: Colors.red),)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

