import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ImageClassificationScreen extends StatefulWidget {
  @override
  ImageClassificationScreenState createState() =>
      ImageClassificationScreenState();
}

class ImageClassificationScreenState extends State<ImageClassificationScreen> {
  File? _image;
  List? _results;
  bool imageSelect = false;

  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();

    String res;

    res = (await Tflite.loadModel(
        model: 'assets/model.tflite', labels: 'assets/labels.txt'))!;

    print("Model loading status: $res");
  }

  Future imageClassification(File image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        // required
        imageMean: 0.0,
        // defaults to 117.0
        imageStd: 255.0,
        // defaults to 1.0
        numResults: 2,
        // defaults to 5
        threshold: 0.2,
        // defaults to 0.1
        asynch: true // defaults to true
    );

    setState(() {
      _results = recognitions;
      _image = image;
      imageSelect = true;
    });
  }

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    final XFile? pickedFile2 =
    await _picker.pickImage(source: ImageSource.camera);

    File image = File(pickedFile!.path);
    File image2 = File(pickedFile2!.path);

    imageClassification(image);
    imageClassification(image2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Classification'),
      ),
      body: ListView(
        children: [
          (imageSelect)
              ? Container(
            margin: EdgeInsets.all(10),
            child: Image.file(_image!),
          )
              : Container(
            margin: EdgeInsets.all(10),
            child: Opacity(
              opacity: 0.8,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? pickedFile = await _picker
                                .pickImage(source: ImageSource.gallery);
                            File image = File(pickedFile!.path);

                            imageClassification(image);
                          },
                          child: Container(
                            height: 70.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber,
                            ),
                            child: Center(
                              child: Icon(Icons.image_outlined),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('GALLERY')
                      ],
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? pickedFile = await _picker
                                .pickImage(source: ImageSource.camera);
                            File image = File(pickedFile!.path);

                            imageClassification(image);
                          },
                          child: Container(
                            height: 70.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber,
                            ),
                            child: Center(
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('CAMERA')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: (imageSelect)
                  ? _results!.map((result) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Text(
                          'Label: ${result['label']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Card(
                        child: Text(
                          'Confidence: ${result['confidence'].toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                      ),

                      SizedBox(height: 20.0,),

                      Divider(color: Colors.black,thickness: 2.0,),

                      // ElevatedButton(onPressed: (){
                      //   SimpleDialog(
                      //     title: Text('Choose an option'),
                      //     children: [
                      //
                      //       Divider(
                      //         color: Colors.black,
                      //         thickness: 2.0,
                      //       ),
                      //
                      //       SimpleDialogOption(
                      //         child: Text('Open Gallery'),
                      //         onPressed: (){
                      //
                      //         },
                      //       ),
                      //
                      //       SimpleDialogOption(
                      //         child: Text('Open Camera'),
                      //         onPressed: (){
                      //
                      //         },
                      //       ),
                      //
                      //     ],
                      //   );
                      // }, child: Text('Search More')),
                    ],
                  ),
                );
              }).toList()
                  : [],
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: (){
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => ImageClassificationScreen()));
      //   },
      //   label: Text('Search More'),
      //   icon: Icon(Icons.add_a_photo),
      // ),
    );
  }
}

/*
Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      '${result['label']} -${result['confidence'].toStringAsFixed(2)}',
                      style: TextStyle(
                          color:Colors.red,
                          fontSize: 20),
                    ),
                  ),
 */
