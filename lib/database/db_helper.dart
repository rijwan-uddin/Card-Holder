import 'package:cardholder/models/contact_model.dart';
import 'package:path/path.dart' as P;
import 'package:sqflite/sqflite.dart';
class DbHelper {
  final String _createTableContact= '''create table $tableContact(
  $tblContactColId integer primary key autoincrement,
  $tblContactColName text,
  $tblContactColPhone text,
  $tblContactColEmail text,
  $tblContactColAddress text,
  $tblContactColCompany text,
  $tblContactColDesignation text,
  $tblContactColWebsite text,
  $tblContactColImage text,
  $tblContactColFavorite text)''';

  Future<Database> _open() async {
    final root = await getDatabasesPath();
    final dbPath = P.join(root,'contact.db');
    return openDatabase(dbPath , version : 1, onCreate: (db,version){
    db.execute(_createTableContact);
    });
  }

}