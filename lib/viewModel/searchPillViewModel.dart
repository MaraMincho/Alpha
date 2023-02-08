import 'dart:typed_data';

import 'package:alpha/model/pill.dart';
import 'package:alpha/viewModel/DatabaseHelper.dart';
import 'package:get/get.dart';
import 'package:alpha/viewModel/APIrepo.dart';
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