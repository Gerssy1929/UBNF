import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

import '../../../domain/controllers/Firebase/controllerUser.dart';

class Peticiones {
  static final ControlUserAuth controlu = Get.find();
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> perfil(Map<String, dynamic> user) async {
    //print(catalogo['foto']);

    var url = '';
    // if (foto != null) {
    //   url = await Peticiones.cargarfoto(foto, controlua.userValido!.user!.uid);
    // }
    print(url);
    //catalogo['foto'] = url.toString();

    await _db
        .collection('Usuarios')
        .doc(controlu.userValido!.user!.uid)
        .set(user)
        .catchError((e) {
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

  // static Future<void> getPerfil() async {
  //   await _db.collection('Usuarios').doc(controlu.userValido!.user!.uid).get();
  // }

  static Future<Map<String, dynamic>> getPerfil() async {
    try {
      DocumentSnapshot doc = await _db
          .collection('Usuarios')
          .doc(controlu.userValido!.user!.uid)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Devuelve los datos del documento
        return data;
      } else {
        print('El documento no existe');
      }
    } catch (e) {
      print('Error al obtener los datos: $e');
    }

    // Si ocurre un error o el documento no existe, devuelve un mapa vacío
    return {};
  }

  static Future<void> actualizarPerfil(
      String id, Map<String, dynamic> catalogo) async {
    await _db.collection('Usuarios').doc(id).update(catalogo).catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<void> eliminarPerfil(String id) async {
    await _db.collection('Usuarios').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }
}
