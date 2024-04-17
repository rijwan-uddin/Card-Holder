import 'package:cardholder/models/contact_model.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  static const String routeName= 'form';
  final contactModel;
  const FormPage({super.key,required this.contactModel});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contactModel.name),
      ),
    );
  }
}
