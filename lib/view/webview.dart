import 'package:alpha/viewModel/WebviewC.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      //   shadowColor: Colors.white.withOpacity(0),
      // ),
      body: SafeArea(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {Get.back();},
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 45, 25, 20),
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.arrow_back,
                        size: 40,
                      )),
                ),
              ),
              Expanded(child: WebViewWidget(controller: controller)),
            ],
          ),
      ),
    );
  }
}
