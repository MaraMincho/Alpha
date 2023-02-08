
import 'package:alpha/view/test6_croopScreen.dart';
import 'package:alpha/view/test2_imageTest.dart';
import 'package:alpha/view/ImageCropScreen.dart';
import 'package:alpha/viewModel/TestController.dart';
import 'package:alpha/viewModel/searchPillViewModel.dart';
import 'package:alpha/viewModel/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/pill.dart';
import 'test4.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  var testViewModel = Get.put(SearchPillViewModel());
  var testController = Get.put(TestController());
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
                    testViewModel.getPill();
                  },
                  child: Text("GetPillFromServer")),
              ElevatedButton(
                  onPressed: () async{
                    print(testViewModel.currentPill.toJson());
                    print(testViewModel.currentPill.bookMarking.toString());
                  },
                  child: Text("ShowCurrentPill")),
              ElevatedButton(
                  onPressed: () async{
                    var temp = await DatabaseHelper.instance.insert(testViewModel.currentPill);
                    print(temp.runtimeType);
                  },
                  child: Text("InsertPillToDB")),
              ElevatedButton(
                  onPressed: () async{
                    await testViewModel.getPillFromDB();
                  },
                  child: Text("showPill")),
              ElevatedButton(
                  onPressed: () async{
                    testViewModel.userPillList.forEach((element) {print(element.image?.data);});
                    Get.to(Test2());
                  },
                  child: Text("userPillList")),
              ElevatedButton(
                  onPressed: () async{
                    await DatabaseHelper.instance.deleteDatabase();
                  },
                  child: Text("dropDB")),
              ElevatedButton(
                  onPressed: () async{
                    print(Pill.instance.image?.type);
                  },
                  child: Text("printtype")),
              ElevatedButton(
                  onPressed: () async{
                    Get.to(ImageCropScreen());
                  },
                  child: Text("to crop page")),
              ElevatedButton(
                  onPressed: () async{
                    Get.to(Test4());
                  },
                  child: Text("to crop example page")),
              ElevatedButton(
                  onPressed: () async{
                    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                    testController.temp = await image?.readAsBytes();
                    Get.to(CropScreen());
                  },
                  child: Text("Image Picker")),
              //Image.memory(Uint8List.fromList(testViewModel.currentPill.image!.data!)),
            ],
          )
        ),
      ),
    );
  }
}
//
// class Temp extends StatelessWidget {
//   const Temp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: MediaQuery.of(context).size.width,
//           height: 1,
//           color: Colors.black.withOpacity(0.3),),
//         Padding(
//           padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                   flex: 30,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ClipOval(
//                       child: Image.asset('images/imgs/img.png'),
//                     ),
//                   )
//               ),
//               Expanded(flex: 5, child: SizedBox()),
//               Expanded(
//                 flex: 80,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                               flex: 3,
//                               child: Text('정다함')),
//                           Expanded(
//                               flex: 12,
//                               child: Text('2023-01-19', style: TextStyle(color: Colors.black.withOpacity(0.6)),))
//                         ],
//                       ),
//                       Text('''얼마나 많은 세월이 흘러야 잊혀지려나
// 지금 여기 너 떠난 후에 나는 이렇게 쓸쓸한데
//
// 모두들 얘기를 하지 세월이 약이 될거라
// 지금 여기 너 떠난 후에 나는 이렇게 쓸쓸한데
//
// 다시 한번 내 가슴에 널 안을 수 있다면
// 너의 작은 심장이 두근대는 그 소리를
//
// 다시 들을 수도 없고 다시 안을 수도 없고
// 다만 눈물로 묻어둘 밖에 안녕 잘 가라 내 사랑
//
//
//
// 다시 한번 내 가슴에 널 안을 수 있다면
// 너의 작은 심장이 두근대는 그 소리를
//
// 다시 들을 수도 없고 다시 안을 수도 없고
// 다만 눈물로 묻어둘 밖에 안녕 잘 가라 내 사랑
//
// 얼마나 많은 세월이 흘러야 잊혀지려나
// 지금 여기 너 떠난 후에 나는 이렇게 쓸쓸한데
//                                 ''')
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
