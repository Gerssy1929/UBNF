import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubnf/domain/controllers/Firebase/controllerProp.dart';
import 'package:ubnf/domain/controllers/Firebase/controllerUser.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String pass;

  @override
  Widget build(BuildContext context) {
    ControlUserAuth controlu = Get.find();
    ControlProp controlp = Get.find();
    return Scaffold(
        body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              right: 35, left: 35, top: MediaQuery.of(context).size.height * 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                  Text('Bienvenido',
                      style: TextStyle(color: Colors.black, fontSize: 25.0)),
                ],
              ),
            ),
            TextFormField(
              style: const TextStyle(
                  // Cambia el color del texto a azul
                  fontSize: 16.0),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                labelStyle: const TextStyle(
                  color: Colors.blueGrey,
                ),
                hintText: 'Ingresa tu correo...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              validator: Validatorless.multiple([
                Validatorless.email("Ingrese un email válido"),
                Validatorless.required('El campo es obligatorio')
              ]),
              onSaved: (value) {
                email = value!;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: const TextStyle(
                  color: Colors.blueGrey,
                ),
                hintText: 'Ingresa tu contraseña...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              validator: Validatorless.multiple(
                  [Validatorless.required('El campo es obligatorio')]),
              onSaved: (value) {
                pass = value!;
              },
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    controlu.loginUser(email, pass).then((value) {
                      if (controlu.userValido == null) {
                        Get.snackbar('Usuarios', controlu.mensajesUser,
                            duration: const Duration(seconds: 3),
                            icon: const Icon(Icons.info),
                            shouldIconPulse: true,
                            backgroundColor: Colors.blueAccent);
                      } else {
                        //  controlp
                        //         .getPetsGral()
                        //         .then((value) => Get.toNamed("/listaPets"));
                        controlp
                            .listProp()
                            .then((value) => Get.toNamed("/places"));
                      }
                    });
                    // Aquí puedes validar las credenciales con tu backend
                    // y navegar a la siguiente pantalla si son correctas.
                  }
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(10, 40)),
                  backgroundColor: MaterialStateProperty.all(Colors
                      .blueAccent), // Cambia el color de fondo del botón a rojo
                  foregroundColor: MaterialStateProperty.all(Colors
                      .white), // Cambia el color del texto del botón a blanco
                ),
                child: const Text('Iniciar Sesión')),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Get.toNamed("/register");
              },
              child: const Text(
                'Registrarse',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 18,
                  color: Color(0xff4c505b),
                ),
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
