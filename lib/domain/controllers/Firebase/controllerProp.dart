import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ubnf/data/services/Firebase/fireProp.dart';

final Rxn<Stream<QuerySnapshot<Map<String, dynamic>>>> _listProperty =
    Rxn<Stream<QuerySnapshot<Map<String, dynamic>>>>();

final Rxn<Stream<QuerySnapshot<Map<String, dynamic>>>> _listPropertyUser =
    Rxn<Stream<QuerySnapshot<Map<String, dynamic>>>>();

class ControlProp extends GetxController {
  Future<void> createProp(Map<String, dynamic> prop, foto) async {
    await PeticionesProp.createProp(prop, foto);
  }

  Future<void> updateProp(String id, Map<String, dynamic> prop, foto) async {
    await PeticionesProp.updateProp(id, prop, foto);
  }

  Future<void> deleteProp(String id) async {
    await PeticionesProp.deleteProp(id);
  }

  Future<void> listProp() async {
    _listProperty.value = await PeticionesProp.getListProp();
  }

  Future<void> listPropUser() async {
    _listPropertyUser.value = await PeticionesProp.getListPropUser();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? get listProperty =>
      _listProperty.value;

  Stream<QuerySnapshot<Map<String, dynamic>>>? get listPropertyUser =>
      _listPropertyUser.value;
}
