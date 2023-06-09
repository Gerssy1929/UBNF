import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:ubnf/domain/controllers/Firebase/controllerProp.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/controllers/Firebase/controllerUser.dart';

class PeticionesProp {
  static final ControlUserAuth controlu = Get.find();
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> createProp(Map<String, dynamic> prop, foto) async {
    print(prop['foto']);

    var url = '';
    if (foto != null) {
      url = await PeticionesProp.cargarfoto(foto);
    }
    print(url);
    prop['foto'] = url.toString();

    await _db.collection('Propiedades').doc().set(prop).catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<dynamic> cargarfoto(var foto) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("PropFotos");

    String idPhoto = Uuid().v4();

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child("$idPhoto.jpg").putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    print('url:' + url.toString());
    return url.toString();
  }

  static Future<void> updateProp(
      String id, Map<String, dynamic> prop, foto) async {
    print(prop['foto']);

    var url = '';
    if (foto != null) {
      url = await PeticionesProp.cargarfoto(foto);
    }
    print(url);
    prop['foto'] = url.toString();
    await _db.collection('Propiedades').doc(id).update(prop).catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<void> deleteProp(String id) async {
    await _db.collection('Propiedades').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<dynamic> getListProp() async {
    return _db.collection('Propiedades').snapshots();
  }

  static Future<dynamic> getListPropUser() async {
    return _db
        .collection('Propiedades')
        .where('owner', isEqualTo: controlu.userValido!.user!.uid)
        .snapshots();
  }
}
