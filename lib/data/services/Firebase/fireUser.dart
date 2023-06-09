import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLogin {
  static final FirebaseAuth auth = FirebaseAuth.instance;

//Registro Usando Correo Electronico y Contraseña
  static Future<dynamic> register(dynamic email, dynamic pass) async {
    try {
      UserCredential usuario = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);

      print("funcion " + usuario.toString());
      return usuario;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Contraseña Debil');
        return '1';
      } else if (e.code == 'email-already-in-use') {
        print('Correo ya Existe');
        return '2';
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> login(dynamic email, dynamic pass) async {
    try {
      UserCredential usuario =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      return usuario;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Correo no encontrado');
        return '1';
      } else if (e.code == 'wrong-password') {
        print('Password incorrecto');
        return '2';
      }
    }
  }

  static Future<dynamic> cerrarSesion() async {
    await auth.signOut();
    return 'Sesión cerrada correctamente';
  }
}
