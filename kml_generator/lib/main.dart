import 'package:flutter/material.dart';
import 'package:kml_generator/src/pages/home_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: Center(child: MainPage()));
  }
}
