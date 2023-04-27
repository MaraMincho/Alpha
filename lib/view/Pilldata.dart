import 'package:alpha/viewModel/searchPillViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
class CurrentPillData extends StatelessWidget {
  const CurrentPillData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchPillViewModel = Get.put(SearchPillViewModel());
    print(searchPillViewModel.currentDetailPill?.useMethodQesitm);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.memory(Uint8List.fromList(searchPillViewModel.currentPill.image!.data!)),
              Text("알약 이름 : ${searchPillViewModel.currentDetailPill?.itemName}", style: TextStyle(fontSize: 18),),
              Text("회사 이름 : ${searchPillViewModel.currentDetailPill?.entpName}",style: TextStyle(fontSize: 18),),
              Text("사용 목적 : ${searchPillViewModel.currentDetailPill?.efcyQesitm}"),
              Text("사용 방법 : ${searchPillViewModel.currentDetailPill?.useMethodQesitm}"),
              Text("주의 사항 : ${searchPillViewModel.currentDetailPill?.intrcQesitm}")
            ],
          ),
        ),
      ),
    );
  }
}
