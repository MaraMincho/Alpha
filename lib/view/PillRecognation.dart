
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
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 2,
                title: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Center(
                      child: Text("알약을 찍어주세요!", style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: -1, color: Colors.black)),
                    )
                )
            ),
            shadowColor: Colors.red.withOpacity(0),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text("다음의 것들을 주의해야 합니다!",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1.5,)
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 35,),
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
                GoodAndBadImageDescription(
                    titleText: '배경 이미지를 안보이게 찍어주세요',
                    goodImageDescription: '잘찍었음',
                    badImageDescription: '못 찍었음',
                    goodImageUrl: 'images/imgs/AIRecognationIdealPhotoGuide/idealNoZoom.png',
                    badImageUrl: 'images/imgs/AIRecognationIdealPhotoGuide/BadNoZoom.png'),



                Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
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
                Container(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
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
                    )
                ),
                SizedBox(height: 30,),
              ],

              )
          ),
        ],
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

