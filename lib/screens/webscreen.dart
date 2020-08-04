import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webscreen extends StatelessWidget {
  final String url;
  final String title;

  const Webscreen({this.title, this.url});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.black87,
        ),
        body: WebView(
          initialUrl: url,
        ),
      ),
    );
  }
}
