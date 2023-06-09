import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

import '../../../domain/controllers/Firebase/controllerUser.dart';

class PeticionesRent {
  static final ControlUserAuth controlu = Get.find();
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> crearRent(Map<String, dynamic> rent) async {
    //print(catalogo['foto']);

    var url = '';
    // if (foto != null) {
    //   url = await Peticiones.cargarfoto(foto, controlua.userValido!.user!.uid);
    // }
    print(url);
    //catalogo['foto'] = url.toString();

    await _db.collection('Rentas').doc().set(rent).catchError((e) {
      print(e);
    });
    //return true;
  }

  // static Future<dynamic> cargarfoto(var foto, var idArt) async {
  //   final fs.Reference storageReference =
  //       fs.FirebaseStorage.instance.ref().child("fotos");

  //   fs.TaskSnapshot taskSnapshot =
  //       await storageReference.child(idArt).putFile(foto);

  //   var url = await taskSnapshot.ref.getDownloadURL();
  //   print('url:' + url.toString());
  //   return url.toString();
  // }

  static Future<void> actualizarRent(
      String id, Map<String, dynamic> rent) async {
    await _db.collection('Rentas').doc(id).update(rent).catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<void> eliminarcatalogo(String id) async {
    await _db.collection('Rentas').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }
}
