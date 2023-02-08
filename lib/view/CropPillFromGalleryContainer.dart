import 'dart:typed_data';

import 'package:alpha/viewModel/CropViewModel.dart';
import 'package:alpha/viewModel/searchPillViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'ImageCropScreen.dart';

class CropPillFromGalleryContainer extends StatelessWidget {
  CropPillFromGalleryContainer({Key? key, required this.titleText, required this.image}) : super(key: key);
  final cropViewModel = Get.put(CropViewModel());
  final searchViewModel = Get.put(SearchPillViewModel());
  final String titleText;
  final List<int>? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("${titleText}", style: TextStyle(fontSize: 20),),
        SizedBox(height: 5,),
        InkWell(
          onTap: () async{
            final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
            cropViewModel.currentSelectedImage = await image?.readAsBytes();
            Get.to(ImageCropScreen());
          },
          child: Container(
            width:150,
            height: 150,
            child: image == null ?
            Icon(Icons.add, color: Colors.black.withOpacity(0.5), size: 45) :
            Image.memory(Uint8List.fromList(image!)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.black26)
            ),
          ),
        ),
      ],
    );
  }
}