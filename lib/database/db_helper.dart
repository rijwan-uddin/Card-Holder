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
  Future<int> insertContact(ContactModel contactModel) async {
    final db = await _open();
    return  db.insert(tableContact, contactModel.toMap(),);
  }
 Future <List<ContactModel>> getAllContacts() async {
    final db = await _open();
   final mapList= await db.query(tableContact,);
   return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));

 }
  Future <List<ContactModel>> getAllFavoriteContacts() async {
    final db = await _open();
    final mapList= await db.query(tableContact,where: '$tblContactColFavorite = ? ', whereArgs:  [1]);
    return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));

  }

 Future<int> deleteContact(int id) async{
    final db = await _open();
    return db.delete(tableContact,where: '$tblContactColId = ? ', whereArgs:  [id]);
 }
Future<int> updateFavorite(int id,int value) async {
    final db=await _open();
    return db.update(tableContact, {tblContactColFavorite: value},where: '$tblContactColId = ? ', whereArgs:  [id]);
}
}

















