import 'dart:typed_data';
import 'package:get/get.dart';

class CropViewModel extends GetxController {
  Uint8List? currentSelectedImage;
  Uint8List? currentCroppedImage;
}

class Hodong {
  String? currentString;
  List<String> currentStringList = []; //여기와서 4번 실행 => 값 추가됨


  static Hodong instance = Hodong();


  void copyCurrentString(String inputString) {
    instance.currentString = inputString; //여기와서 2번 실행
    addCurrentStringList();
  }
  void addCurrentStringList() {
    currentStringList.add(currentString!); //여기와서 3번 실행
  }

}
void main() {
  String? serviceInputValue = "인풋 값";
  var hodongController = Hodong.instance;
  hodongController.copyCurrentString(serviceInputValue); //1번 실행


}



