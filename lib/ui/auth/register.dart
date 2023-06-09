import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import '../../domain/controllers/Firebase/controllerUser.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ControlUserAuth controlu = Get.find();
    late String email;
    late String pass;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(right: 35, left: 35, top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 56, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Image(
                              image: AssetImage('assets/images/logo.png'),
                              width: 85,
                              height: 100,
                              fit: BoxFit.fitWidth,
                            ))
                      ],
                    )),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('Empezemos...',
                          style:
                              TextStyle(color: Colors.black, fontSize: 25.0)),
                    ],
                  ),
                ),
                TextFormField(
                  //controller: email,
                  style: const TextStyle(
                      color: Colors.blue, // Cambia el color del texto a azul
                      fontSize: 16.0),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      hintText: 'Correo',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                      focusColor: Colors.deepPurple),
                  validator: Validatorless.multiple([
                    Validatorless.email("Ingrese un email válido"),
                    Validatorless.required('El campo es obligatorio')
                  ]),
                  onSaved: (value) {
                    email = value!;
                  },
                ),
                const SizedBox(height: 5.0),
                TextFormField(
                  //controller: pass,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Contraseña',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                  ),
                  validator: Validatorless.multiple(
                      [Validatorless.required('El campo es obligatorio')]),
                  onSaved: (value) {
                    pass = value!;
                  },
                ),
                const SizedBox(height: 5.0),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        controlu.createUser(email, pass).then((value) {
                          if (controlu.userValido == null) {
                            Get.snackbar("Usuarios", controlu.mensajesUser,
                                duration: const Duration(seconds: 4),
                                backgroundColor: Colors.amber);
                          } else {
                            Get.snackbar("Usuarios", controlu.mensajesUser,
                                duration: const Duration(seconds: 4),
                                backgroundColor: Colors.amber);
                            Get.toNamed("/login");
                          }
                        });
                      }
                    },
                    // Aquí puedes validar las credenciales con tu backend
                    // y navegar a la siguiente pantalla si son correctas
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(10, 40)),
                      backgroundColor: MaterialStateProperty.all(Colors
                          .blueAccent), // Cambia el color de fondo del botón a rojo
                      foregroundColor: MaterialStateProperty.all(Colors
                          .white), // Cambia el color del texto del botón a blanco
                    ),
                    child: const Text('Crear Cuenta')),
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.toNamed("/login"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
