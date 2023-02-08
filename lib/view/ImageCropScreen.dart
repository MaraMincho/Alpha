import 'package:alpha/view/mainScreen.dart';
import 'package:alpha/viewModel/CropViewModel.dart';
import 'package:alpha/viewModel/searchPillViewModel.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ImageCropScreen extends StatefulWidget {
  ImageCropScreen({Key? key}) : super(key: key);

  @override
  State<ImageCropScreen> createState() => _ImageCropScreenState();
}

class _ImageCropScreenState extends State<ImageCropScreen> {
  var cropViewModel = Get.put(CropViewModel());
  final _controller = CropController();
  var searchPillViewModel = Get.put(SearchPillViewModel());
  Uint8List? _croppedData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Crop(
                maskColor: Colors.black12,
                  image: cropViewModel.currentSelectedImage!,
                  controller: _controller,
                  onCropped: (image) {
                    setState(() {
                      _croppedData = image;
                      cropViewModel.currentCroppedImage = _croppedData;
                      //왼쪽부터 알약 채워넣기
                      if (searchPillViewModel.firstCroppedImage == null) {
                        searchPillViewModel.firstCroppedImage = _croppedData;
                      }
                      else{
                        searchPillViewModel.secondCroppedImage = _croppedData;
                      }

                      Get.delete<CropViewModel>();
                      Get.off(MainScreen());
                    });
                  }
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.black.withOpacity(0.2),
                          width: 1,
                        ),
                        shadowColor: Colors.black.withOpacity(0.4),
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black
                    ),
                    onPressed: ()async{
                      _controller.crop();
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                              child: Icon(Icons.crop, size: MediaQuery.of(context).size.width * 0.1,)),
                        ),
                        Expanded(
                          flex: 10,
                          child: Container(
                              alignment: Alignment.center,
                              child: Text('사진 잘라내기', style: TextStyle(fontSize: 15, letterSpacing: -1),)),
                        )
                      ],
                    ),
                  )
              ),
            ),
          ],
        ),
      )
    );
  }
}
