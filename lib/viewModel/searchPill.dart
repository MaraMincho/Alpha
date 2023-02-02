import 'package:alpha/model/pill.dart';
import 'package:get/get.dart';
import 'package:alpha/viewModel/APIrepo.dart';
class SearchPillViewModel extends GetxController {
  var repo = Get.put((APIrepo()));

  Pill currentPill = new Pill();

  dynamic getHome() async{
    var response = await repo.getHomerepo();
    print(response.body);
  }

  dynamic getPill() async {
    var response = await repo.getDetailinforepo();
    currentPill = Pill.fromJson(response.body);
    print(currentPill.name);
  }
}