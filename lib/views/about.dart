import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/app/app.dart';
import 'package:webview_flutter/webview_flutter.dart';

class About extends StatefulWidget {

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  WebViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App().appBarBack(context, 'About'),
      body: Container(
        child: buildView(),
      ),
    );
  }

  Widget buildView(){
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: 'https://inses.in/aboutus/',
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
        _controller.loadUrl('https://inses.in/aboutus/');
      },
    );
  }

}
