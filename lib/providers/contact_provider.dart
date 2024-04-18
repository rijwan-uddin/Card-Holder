import 'package:cardholder/database/db_helper.dart';
import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];
  final db = DbHelper();

  Future<int> insertContact(ContactModel contactModel) async {
    return db.insertContact(contactModel);
  }
  Future<void> getAllContacts() async {
    contactList = await db.getAllContacts();
    notifyListeners();
  }
}
