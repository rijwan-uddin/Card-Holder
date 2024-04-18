const String tableContact = 'tbl_contact';
const String tblContactColId ='id';
const String tblContactColName ='name';
const String tblContactColPhone ='phone';
const String tblContactColEmail ='email';
const String tblContactColAddress ='address';
const String tblContactColCompany ='company';
const String tblContactColDesignation ='designation';
const String tblContactColWebsite ='website';
const String tblContactColImage ='image';
const String tblContactColFavorite ='favorite';


class ContactModel{
  int id;
  String name;
  String phone;
  String email;
  String address;
  String company;
  String designation;
  String website;
  String image;
  bool favorite;

  ContactModel({
    this.id=-1,
    required this.name,
    required this.phone,
    this.email='',
    this.address='',
    this.company='',
    this.designation='',
    this.website='',
    this.image='',
    this.favorite=false,
  });

  Map<String, dynamic> toMap(){
    final map = <String, dynamic>{
      tblContactColName : name,
      tblContactColPhone : phone,
      tblContactColEmail : email,
      tblContactColAddress : address,
      tblContactColCompany : company,
      tblContactColDesignation: designation,
      tblContactColWebsite : website,
      tblContactColImage : image,
      tblContactColFavorite: favorite ? 1 : 0,


    };

    if(id > 0){
      map[tblContactColId] = id;
    }
    return map;
  }
}