import 'package:cardholder/models/contact_model.dart';
import 'package:cardholder/pages/home_page.dart';
import 'package:cardholder/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../utils/helper_function.dart';

class FormPage extends StatefulWidget {
  static const String routeName = 'form';
  final contactModel;

  const FormPage({super.key, required this.contactModel});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final companyController = TextEditingController();
  final designationController = TextEditingController();
  final webController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.contactModel.name;
    phoneController.text = widget.contactModel.phone;
    emailController.text = widget.contactModel.email;
    addressController.text = widget.contactModel.address;
    companyController.text = widget.contactModel.company;
    designationController.text = widget.contactModel.designation;
    webController.text = widget.contactModel.website;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
        actions: [
          IconButton(onPressed: saveContact, icon: const Icon(Icons.save),)
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Contact name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrMsg;
                }
                return null;
              },
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrMsg;
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email ',
              ),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
              ),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              controller: companyController,
              decoration: InputDecoration(
                labelText: 'Company',
              ),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              controller: designationController,
              decoration: InputDecoration(
                labelText: 'Designation',
              ),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              controller: webController,
              decoration: InputDecoration(
                labelText: 'Website',
              ),
              validator: (value) {
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    companyController.dispose();
    designationController.dispose();
    webController.dispose();

    super.dispose();
  }

  void saveContact() async {
    if(_formKey.currentState!.validate()){

      widget.contactModel.name = nameController.text;
      widget.contactModel.phone = phoneController.text;
      widget.contactModel.email = emailController.text;
      widget.contactModel.address = addressController.text;
      widget.contactModel.company = companyController.text;
      widget.contactModel.designation = designationController.text;
      widget.contactModel.website = webController.text;
      // print(widget.contactModel);


    Provider.of<ContactProvider>(context, listen: false)
        .insertContact(widget.contactModel)
    .then((value){
      if(value > 0){
        showMsg(context,'Saved');
        context.goNamed(homepage.routeName);
      }
    })
    .catchError((error){
      showMsg(context,'Failed to save');


    });
  }
}
}