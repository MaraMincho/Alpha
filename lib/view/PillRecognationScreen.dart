import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
          padding: EdgeInsets.fromLTRB(25, 40, 25, 0),
          child: Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text("알약을 찍어주세요!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, letterSpacing: -1),),
                  SizedBox(height: 5,),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                      child: Text("다음의 것들을 주의하셔야 합니다", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, letterSpacing: -1, color: Colors.red),)),
                  SizedBox(height: 30,),
                  PictureGuideBox(goodImagePath: 'images/imgs/img.png', badImagePath: 'images/imgs/img.png', BadImageText: '인식이 힘든 사진', GoodImageText: '인식이 잘 되는 사진', titleText: '배경 이미지를 안보이게 찍어주세요'),
                  PictureGuideBox(goodImagePath: 'images/imgs/img.png', badImagePath: 'images/imgs/img.png', BadImageText: '인식이 힘든 사진', GoodImageText: '인식이 잘 되는 사진', titleText: '배경 이미지를 안보이게 찍어주세요'),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.black.withOpacity(0.2),
                          width: 1,
                        ),
                        shadowColor: Colors.black.withOpacity(0.4),
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black
                      ),
                      onPressed: ()async{
                        final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                        print(image?.path);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                                child: Icon(Icons.folder_copy, size: MediaQuery.of(context).size.width * 0.1,)),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              alignment: Alignment.center,
                                child: Text('앨범에서 가져오기', style: TextStyle(fontSize: 15, letterSpacing: -1),)),
                          )

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.black.withOpacity(0.2),
                            width: 1,
                          ),
                          shadowColor: Colors.black.withOpacity(0.4),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black
                      ),
                      onPressed: ()async{
                        final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
                        print(image?.path);

                      },
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                                child: Icon(Icons.camera_alt_rounded, size: MediaQuery.of(context).size.width * 0.1,)),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                                alignment: Alignment.center,
                                child: Text('카메라로 찍기', style: TextStyle(fontSize: 15, letterSpacing: -1),)),
                          )
                        ],
                      ),
                    ),
                  )

                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}

class PictureGuideBox extends StatelessWidget {

  final String goodImagePath;
  final String badImagePath;
  final String GoodImageText;
  final String BadImageText;
  final String titleText;

  PictureGuideBox({Key? key,
    required this.goodImagePath,
    required this.badImagePath,
    required this.BadImageText,
    required this.GoodImageText,
    required this.titleText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(fit: BoxFit.scaleDown, child: Text('배경이미지를 안보이게 찍어주세요', style: TextStyle(fontSize: 20, letterSpacing: -1),)),
        SizedBox(height: 8,),
        Row(
          children: [
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Image.asset('images/imgs/img.png'),
                  Text('인식이 힘든 사진', style: TextStyle(fontSize: 15, letterSpacing: -1, color: Colors.redAccent),)
                ],
              ),
            ),
            Expanded(
              flex: 2,
                child: Container()),
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Image.asset('images/imgs/img.png'),
                  Text('인식이 잘 되는 사진', style: TextStyle(fontSize: 15, letterSpacing: -1, color: Colors.black),)
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}


