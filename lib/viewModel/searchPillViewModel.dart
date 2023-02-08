import 'dart:io';
import 'dart:typed_data';
import 'package:alpha/model/pill.dart';
import 'package:alpha/viewModel/DatabaseHelper.dart';
import 'package:get/get.dart';
import 'package:alpha/viewModel/APIrepo.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


class SearchPillViewModel extends GetxController {
  List<Pill> userPillList = [];

  var repo = Get.put((APIrepo()));
  Pill currentPill = new Pill();
  Uint8List? firstCroppedImage;
  Uint8List? secondCroppedImage;

  dynamic getHome() async{
    var response = await repo.getHomerepo();
    print(response.body);
  }

  dynamic getPill() async {
    var response = await repo.getDetailinforepo();
    currentPill = Pill.fromJson(response.body);
    //var queryResult = await DatabaseHelper.instance.insert(currentPill);
  }

  dynamic getPillInfoUsingImgFromServer() async{
    final tempDir = await getApplicationDocumentsDirectory();    print("여긴 어디?");
    await File("${tempDir.path}/pill1").writeAsBytes(firstCroppedImage!);
    await File("${tempDir.path}/pill2").writeAsBytes(secondCroppedImage!);
    String url = 'http://192.168.219.102:3000/pillSearchByImg/notlogin';
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