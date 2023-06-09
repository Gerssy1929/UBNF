import 'package:get/get.dart';
import 'package:ubnf/data/services/SQL/propertyRequest.dart';

import '../../models/message.dart';
import '../../models/property.dart';

class ControlProperty extends GetxController {
  final Rxn<List<Messages>> _listMessages = Rxn<List<Messages>>([]);
  final Rxn<List<Property>> _listProperty = Rxn<List<Property>>([]);

  Future<void> crearProperty(
      int idOwner,
      String picture,
      String name,
      String address,
      String city,
      String descri,
      int price,
      int tax,
      int clean) async {
    _listMessages.value = await PropertyRequest.registerProperty(
        idOwner, picture, name, address, city, descri, price, tax, clean);
  }

  Future<void> updateProperty(
      int id,
      String picture,
      String name,
      String address,
      String city,
      String descri,
      int price,
      int tax,
      int clean) async {
    _listMessages.value = await PropertyRequest.updateProperty(
        id, picture, name, address, city, descri, price, tax, clean);
  }

  Future<void> deleteProperty(int id) async {
    _listMessages.value = await PropertyRequest.deleteProperty(id);
  }

  Future<void> getlistProperty() async {
    _listProperty.value = await PropertyRequest.getListProperty();
  }

  List<Messages>? get listMessages => _listMessages.value;
  List<Property>? get listProperty => _listProperty.value;
}
