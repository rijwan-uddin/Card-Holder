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
}