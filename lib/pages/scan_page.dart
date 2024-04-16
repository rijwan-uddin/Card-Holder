import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  static const String routeName='scan';
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Page'),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Capture'),
              ),
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: Icon(Icons.photo_album),
                label: Text('Gallery'),
              )
            ],
          )
        ],
      ),
    );
  }

  void getImage(ImageSource camera) async {
    final xFile = await ImagePicker().pickImage(
      source: camera,
    );
    if (xFile != null) {
      EasyLoading.show(status: 'Please Wait');
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final recognizedText = await textRecognizer
          .processImage(InputImage.fromFile(File(xFile.path)));
      EasyLoading.dismiss();
      final tempList = <String> [];
      for(var block in recognizedText.blocks){
        for(var line in block.lines){
          tempList.add(line.text);
        }
      }
      print(tempList);
    }
  }
}
