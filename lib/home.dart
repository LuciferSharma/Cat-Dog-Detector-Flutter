
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;

  File _image;
  List _output;
  final picker = ImagePicker();

  @override
  void initState(){
    super.initState();
    loadModel().then((val){
      setState(() {

      });
    });
  }


// running model on an image
  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path ,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd:127.5 );

    setState(() {
      _output = output;
      _loading = false;
    });
  }
  
  
  loadModel() async{
    await Tflite.loadModel(model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  pickImage()async{
    var image = await picker.getImage(source: ImageSource.gallery);
    if(image == null) return null;

    setState(() {
      _image= File(image.path);
    });

    detectImage(_image);

  }

  captureImage()async{
    var image = await picker.getImage(source: ImageSource.camera);
    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    detectImage(_image);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.blueAccent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50,),
            Text("Oblate IN",style: TextStyle(color: Colors.yellow,
            fontSize: 20,),),
            SizedBox(height: 5,),
            Text("Cat and Dog Detector App",style: TextStyle(color:Colors.white,
            fontWeight: FontWeight.w500,fontSize: 30),),
            SizedBox(height: 10,),

            Center(
              child: _loading? Container(
                child: Column(
                  children: [
                    Image.asset("assets/cat&dog.png", scale: 0.5,height: 250,),
                    SizedBox(height: 15,),
                  ],
                ),
              ):Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 250,
                      child: Image.file(_image),
                    ),
                    SizedBox(height: 15,),
                    _output !=null? Text('${_output[0]['label']}', style: TextStyle(
                      color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold
                    ),): Container(
                      child: Text("Null h re BAWA!"),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),

              ),

            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        captureImage();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 200,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 15,
                          vertical: 12
                        ),
                        decoration: BoxDecoration(color: Colors.yellowAccent,
                        borderRadius: BorderRadius.circular(6)),
                        child: Text("Capture a Pic!",
                          style: TextStyle(color: Colors.redAccent,
                              fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(height: 10,),

                    GestureDetector(
                      onTap: (){
                        pickImage();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 200,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 15,
                            vertical: 12
                        ),
                        decoration: BoxDecoration(color: Colors.yellowAccent,
                            borderRadius: BorderRadius.circular(6)),
                        child: Text("Select from Gallery.",
                          style: TextStyle(color: Colors.redAccent,
                              fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
