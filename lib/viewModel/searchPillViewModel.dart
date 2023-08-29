import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:alpha/model/detailPill.dart';
import 'package:alpha/model/pill.dart';
import 'package:alpha/view/Pilldata.dart';
import 'package:alpha/view/mainScreen.dart';
import 'package:alpha/viewModel/DatabaseHelper.dart';
import 'package:alpha/viewModel/IP.dart';
import 'package:get/get.dart';
import 'package:alpha/viewModel/APIrepo.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'CropViewModel.dart';


class SearchPillViewModel extends GetxController {
  List<Pill> userPillList = [];

  var tempResponse;
  var repo = Get.put((APIrepo()));
  var dbHelper = DatabaseHelper.instance;
  Pill currentPill = new Pill();
  DetailPillModel? currentDetailPill;
  Uint8List? firstCroppedImage;
  Uint8List? secondCroppedImage;

  dynamic getHome() async{
    var response = await repo.getHomerepo();
    print(response.body);
  }

  dynamic getPill(int id) async {
    var response = await repo.getDetailinforepo(id);
    print(response.body);

    currentPill = Pill.fromJson(response.body);
    //var queryResult = await DatabaseHelper.instance.insert(currentPill);
  }
  dynamic getDetailPillFromAPI(int id) async {
    print("id는?");
    print(id);
    var response = await repo.getDetailinfoFromAPIrepo(id);

    print(response.body);
    currentDetailPill = DetailPillModel.fromJson(response.body);
    //var queryResult = await DatabaseHelper.instance.insert(currentPill);
  }


  dynamic getPillInfoUsingImgFromServer() async{
    print("파일 전송 중");
    final tempDir = await getApplicationDocumentsDirectory(); //저장 위치
    await File("${tempDir.path}/pill1").writeAsBytes(firstCroppedImage!);
    await File("${tempDir.path}/pill2").writeAsBytes(secondCroppedImage!);
    String url = '$baseIP/pillSearchByImg/notlogin';
    var request = new http.MultipartRequest("POST", Uri.parse(url));
    request.headers.addAll({"Accept" : "application/json"});
    request.files.add(await http.MultipartFile.fromPath(
      "img1",
      "${tempDir.path}/pill1",
    ));
    request.files.add(await http.MultipartFile.fromPath(
      "img2",
      "${tempDir.path}/pill2",
    ));
    var response = await request.send();
    if (response.statusCode == 204 ) {
      print("없는 데이터임");
      Get.delete<CropViewModel>();
      Get.delete<SearchPillViewModel>();
      Get.offAll(MainScreen());
      Get.snackbar("에러 메세지", "사진을 다시 입력해주세요!", snackPosition: SnackPosition.TOP);
      return;
    }
    final res = await http.Response.fromStream(response);
    var body = res.body; //알고리즘을 통해 전달 받은 값
    if (body == null) {
      return;
    }
    print("됌?");
    print(body);
    print(currentDetailPill);
    //공공데이터 포탈을 통한 데이터 요청
    var tempBody = jsonDecode(body);
    int id = tempBody[0]["id"];
    currentPill = Pill.fromJson(tempBody[0]);
    await getDetailPillFromAPI(id);
    dbHelper.insert(currentPill, currentDetailPill!);
    Get.to(()=>CurrentPillData());
  }

  dynamic getPillFromDB() async {
    userPillList = [];
    var queryResult = await DatabaseHelper.instance.showPillTables();
    for (var i in queryResult) {
      Pill.instance.id = i['id'];
      Pill.instance.name = i['name'];
      Pill.instance.pillClass = i['pillClass'];
      Pill.instance.form = i['form'];
      Pill.instance.name = i['name'];
      Pill.instance.company = i['company'];
      Pill.instance.image?.data = i['image'];
      var temp = i['bookMarking'];
      if (temp == "true")
        temp = true;
      else
        temp = false;
      Pill.instance.bookMarking = temp;
      userPillList.add(Pill.instance);
    }

  }
}