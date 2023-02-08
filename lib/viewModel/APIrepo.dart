import 'dart:io';

import 'package:get/get.dart';
import 'IP.dart';

class APIrepo extends GetConnect {

  //var userViewModel = Get.put(UserViewModel());
  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = baseIP;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }

  Future<Response> PillSearchByImg(List<int> img1, List<int> img2) async {
    print(img1);
    File('my_image.jpg').writeAsBytes(img1);
    final pathOfImage = await File('images/imgs/searchpillimg1').create();
    await pathOfImage.writeAsBytes(img1);
    var tempimg2 = await File("images/imgs/searchpillimg2").writeAsBytes(img2);
    Response response = await post(
      "/pillSearchByImg/notlogin",
      {
        "img1" : img1,
        "img2" : tempimg2
      },
    );
    print("잘 받아왔음?");
    print(response.body);
    return response;
  }

  Future<Response> getHomerepo() async {
    Response response = await get(
        "/",
    );
    return response;
  }
  Future<Response> getDetailinforepo() async {
    Response response = await get(
      "/detailinfo/notlogin/?id=202000291"
    );
    return response;
  }

}