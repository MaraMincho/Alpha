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