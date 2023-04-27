import 'package:flutter/material.dart';

class DetailPill extends StatelessWidget {
  const DetailPill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
      child: Container(
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black12,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Image border
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(48), // Image radius
                          child: Image.asset('images/imgs/tylenol.png', fit: BoxFit.cover,),
                        ),
                      ),
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Container()),
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text('타이레놀',
                            style: TextStyle(
                              fontSize: 20,
                              letterSpacing: -1,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        Text(
                          '이부프로펜 400밀리그램',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            Text("#해열 진통제", style: TextStyle(color: Colors.red, letterSpacing: -1),),
                            Text("   "),
                            Text("#위장장애 주의", style: TextStyle(color: Colors.blueAccent, letterSpacing: -1),),
                          ],
                        ),
                        Text("#충분한 물 섭취", style: TextStyle(letterSpacing: -1),)
                      ],
                    )
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
