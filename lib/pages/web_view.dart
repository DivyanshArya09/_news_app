// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:news_app/pages/errorPages/something_went_wrong.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final String url;
  const MyWebView({super.key, required this.url});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late WebViewController controller;
  var loading = 0;
  @override
  void initState() {
    // TODO: implement initState
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loading = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loading = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loading = 100;
          });
        },
      ))
      ..loadRequest(
          Uri.parse(widget.url.isEmpty ? 'https//www.google.com' : widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            widget.url.isEmpty
                ? const SomeThingWentWrong()
                : WebViewWidget(controller: controller),
            if (loading < 100)
              LinearProgressIndicator(
                value: loading / 100,
              )
          ],
        ));
  }
}
