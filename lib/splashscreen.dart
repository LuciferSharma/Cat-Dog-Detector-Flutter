import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:cat_dog_identifier/home.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      title: Text("Cat or Dog?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,
      color: Colors.yellow),),
      image: Image.asset("assets/cat&dog.png"),
      backgroundColor: Colors.blueAccent,
      photoSize: 60,
      loaderColor: Colors.teal,
    );
  }
}
