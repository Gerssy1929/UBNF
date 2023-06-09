import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubnf/ui/auth/register.dart';
import 'package:ubnf/ui/content/properties/list.dart';
import 'package:ubnf/ui/content/properties/propsUpdate.dart';
import 'package:ubnf/ui/content/properties/regProp.dart';
import 'package:ubnf/ui/content/properties/userProps.dart';
import 'package:ubnf/ui/content/rents/regRent.dart';
import 'package:ubnf/ui/content/users/perfilUpdate.dart';
import 'package:ubnf/ui/content/users/perfilUser.dart';

import 'auth/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UBNF',
      theme: ThemeData(primarySwatch: Colors.amber),
      initialRoute: '/login',
      routes: {
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/places": (context) => const PropList(),
        "/props": (context) => const RegProp(),
        "/rents": (context) => const RegRent(),
        "/perfilUpdate": (context) => const UpdatePerfil(),
        "/perfilUser": (context) => const PerfilUser(),
        "/userPlaces": (context) => const UserPlaces(),
        "/updatePlace": (context) => const PropUpdate()
        // "/listaStudent": (context) => const ListStudent(),
        // "/registroStudent": (context) => const CrearStudent(),
        // "/actuStudent": (context) => const ActualizarStudent()
      },
    );
  }
}
