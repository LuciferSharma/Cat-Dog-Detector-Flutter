import 'package:flutter/material.dart';
import 'package:cat_dog_identifier/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Identify Cat and Dog",
      home: MySplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
