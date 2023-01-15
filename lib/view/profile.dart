import 'package:flutter/material.dart';

class ProfileViewer extends StatelessWidget {
  const ProfileViewer({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final LargeSizeFont = (size.width / 7);
    return
      Column( // 반응형 상태관리 - 1
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 20,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '안녕하세요',
                        style: TextStyle(
                            fontSize: LargeSizeFont,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1,
                            height: 1),
                      ), //profile 소개 멘트
                      Text(
                        '정다함님',
                        style: TextStyle(
                          fontSize: LargeSizeFont,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1.5
                        ),
                      ),
                      SizedBox(height: 4,),

                      Text(
                        '  오늘도 건강한 하루!',
                        style: TextStyle(
                          fontSize: 21,
                          letterSpacing: -1,
                          color: Colors.black.withOpacity(0.6)
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(child: SizedBox(), flex: 2,),
              Flexible(
                flex: 13,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: PhysicalModel(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    elevation: 5,

                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage('https://k.kakaocdn.net/dn/3Ao8j/btrRuV7XwSp/Xub2ztqAeWFnCbzx7GWBG0/img_640x640.jpg'),
                            fit: BoxFit.fill
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  }
}
