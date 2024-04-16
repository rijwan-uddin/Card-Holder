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
  bool isScanOver = false ;
  List<String> lines = [];
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
          ),
          Wrap(
            children: lines.map((line) => LineItem(line: line)).toList(),
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
      setState(() {

        lines = tempList;
        isScanOver= true;
      });
    }
  }
}

class LineItem extends StatelessWidget {
  final String line;
  const LineItem({super.key, required this.line});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: line,
      dragAnchorStrategy: childDragAnchorStrategy,
      feedback: Container(
        key: GlobalKey(),
        padding: const EdgeInsets.all(8.2),
        decoration: const BoxDecoration(
          //make the drag box circular
          color: Colors.black45,
        ),
        child: Text(
          line,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      child: Chip(
        label: Text(line),
      ),
    );
  }
}

class DropTargetItem extends StatefulWidget {
  final String property;
  final Function(String, String) onDrop;

  const DropTargetItem(
      {super.key, required this.property, required this.onDrop});

  @override
  State<DropTargetItem> createState() => _DropTargetItemState();
}

class _DropTargetItemState extends State<DropTargetItem> {
 String dragItem = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(widget.property),
        ),
        Expanded(
          flex: 2,
          child:DragTarget<String>(
            builder: (context,candidateData, rejectedData) => Container(
              padding: const EdgeInsets.all(8.2),
              decoration: BoxDecoration(
                border: candidateData.isNotEmpty ?
                    Border.all(color: Colors.red, width: 2) : null,
              ),
              child: Row(
                children: [
                  Expanded(child: Text(dragItem.isNotEmpty ? 'Drop here' : dragItem ),

                  ),
                 if(dragItem.isNotEmpty) InkWell(
                    onTap: (){
                      setState(() {

                        dragItem='';
                      });
                    },
                    child: const Icon(Icons.clear, size : 15,),
                  )
                ],
              ),
            ),
            onAccept: (value){
              setState(() {
                if(dragItem.isEmpty){
                  dragItem = value;
                }
                else {
                  dragItem+= '$value';
                }
              });
              widget.onDrop(widget.property, dragItem);
            },
          ),
        ),
      ],
    );
  }
}
