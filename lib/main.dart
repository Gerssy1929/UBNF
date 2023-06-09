import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ubnf/domain/controllers/Firebase/controllerProp.dart';
import 'package:ubnf/domain/controllers/Firebase/controllerUser.dart';
import 'package:ubnf/ui/app.dart';

import 'domain/controllers/Firebase/controllerPerfil.dart';
import 'domain/controllers/Firebase/controllerRent.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  GetPlatform.isWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyBD1q1IC1jAtzzckZ_1GABh3et_dwQmH1s",
              authDomain: "ubnf-63f75.firebaseapp.com",
              projectId: "ubnf-63f75",
              storageBucket: "ubnf-63f75.appspot.com",
              messagingSenderId: "270848046830",
              appId: "1:270848046830:android:81010dd691c5c4532565ff"))
      : await Firebase.initializeApp();

  Get.put(ControlUserAuth());
  Get.put(ControlUserPerfil());
  Get.put(ControlProp());
  Get.put(ControllerRent());
  runApp(const App());
}
