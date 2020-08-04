import 'package:flutter/material.dart';
import 'package:kiimstar/screens/news_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: NewsApp(),
    );
  }
}
