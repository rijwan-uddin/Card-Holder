import 'dart:io';

import 'package:cardholder/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/contact_model.dart';
class ContactDetails extends StatefulWidget {
  static const String routeName = 'details';
  final int id;
  const ContactDetails({super.key, required this.id});

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  late int id;
  @override
  void initState() {
    id= widget.id;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Consumer<ContactProvider>(
        builder:(context ,provider,child)=> FutureBuilder<ContactModel>(
          future: provider.getContactsById(id),
          builder:(context, snapshot) {
            if(snapshot.hasData){
              final contact = snapshot.data!;
              return ListView(
                padding: EdgeInsets.all(8),
                children: [
                  Image.file(File(contact.image), width: double.infinity,height: 250,fit:BoxFit.cover ,)
                ],
              );
            }
            if(snapshot.hasError){
              return Center(child: Text('Failed to load data'),);
            }
            return Center(child: Text('Please wait....'),);
          },
        ),
      ),
    );

  }
}
