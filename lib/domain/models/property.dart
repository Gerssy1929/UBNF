import 'package:ubnf/domain/models/user.dart';

class Property {
  late int id;
  late int idOwner;
  late String picture;
  late String name;
  late String address;
  late String city;
  late String descri;
  late int price;
  late int tax;
  late int clean;

  Property(
      {required this.id,
      required this.idOwner,
      required this.picture,
      required this.name,
      required this.address,
      required this.city,
      required this.descri,
      required this.price,
      required this.tax,
      required this.clean});

  factory Property.fromJson(Map<String, dynamic> jsonMap) {
    return Property(
        id: int.parse(jsonMap['id']),
        idOwner: int.parse(jsonMap['owner']),
        picture: (jsonMap['picture']),
        name: jsonMap['name'],
        address: jsonMap['address'],
        city: jsonMap['city'],
        descri: jsonMap['descri'],
        price: int.parse(jsonMap['price']),
        tax: int.parse(jsonMap['tax']),
        clean: int.parse(jsonMap['clean']));
  }
}
