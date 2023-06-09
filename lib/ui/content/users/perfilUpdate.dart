import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubnf/domain/controllers/Firebase/controllerPerfil.dart';
import 'package:validatorless/validatorless.dart';

class UpdatePerfil extends StatefulWidget {
  const UpdatePerfil({super.key});

  @override
  State<UpdatePerfil> createState() => UpdatePerfilState();
}

class UpdatePerfilState extends State<UpdatePerfil> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ControlUserPerfil controlu = Get.find();

    final args = Get.arguments;

    TextEditingController name = TextEditingController();
    TextEditingController last = TextEditingController();
    TextEditingController tipodoc = TextEditingController();
    TextEditingController doc = TextEditingController();

    name.text = args[0];
    last.text = args[1];
    tipodoc.text = args[2];
    doc.text = args[3];

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
                      Text('Actualiza tu perfil...',
                          style:
                              TextStyle(color: Colors.black, fontSize: 25.0)),
                    ],
                  ),
                ),
                TextFormField(
                  controller: name,
                  style: const TextStyle(
                      color:
                          Colors.blueGrey, // Cambia el color del texto a azul
                      fontSize: 16.0),
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    labelText: 'Nombre',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    hintText: 'Ingrese su nombre',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.onlyCharacters("Solo se aceptan letras"),
                    Validatorless.required('El campo es obligatorio')
                  ]),
                  // onSaved: (value) {
                  //   name = value!;
                  // },
                ),
                const SizedBox(height: 5.0),
                TextFormField(
                  controller: last,
                  style: const TextStyle(
                      color:
                          Colors.blueGrey, // Cambia el color del texto a azul
                      fontSize: 16.0),
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      labelText: 'Apellido',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      hintText: 'Ingrese su apellido',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                      focusColor: Colors.deepPurple),
                  validator: Validatorless.multiple([
                    Validatorless.onlyCharacters("Solo se aceptan letras"),
                    Validatorless.required('El campo es obligatorio')
                  ]),
                  // onSaved: (value) {
                  //   last = value!;
                  // },
                ),
                TextFormField(
                  controller: tipodoc,
                  style: const TextStyle(
                      color:
                          Colors.blueGrey, // Cambia el color del texto a azul
                      fontSize: 16.0),
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.edit_document),
                      labelText: 'Tipo Documento',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      hintText: 'Ingrese tipo doc',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                      focusColor: Colors.deepPurple),
                  validator: Validatorless.multiple([
                    Validatorless.onlyCharacters("Solo se aceptan letras"),
                    Validatorless.required('El campo es obligatorio')
                  ]),
                  // onSaved: (value) {
                  //   tipodoc = value!;
                  // },
                ),
                TextFormField(
                  controller: doc,
                  style: const TextStyle(
                      color:
                          Colors.blueGrey, // Cambia el color del texto a azul
                      fontSize: 16.0),
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.edit_document),
                      labelText: 'Documento',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      hintText: 'Ingrese su # de documento',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                      focusColor: Colors.deepPurple),
                  validator: Validatorless.multiple([
                    Validatorless.number("Solo se aceptan números"),
                    Validatorless.required('El campo es obligatorio')
                  ]),
                  // onSaved: (value) {
                  //   doc = value!;
                  // },
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        Map<String, dynamic> userData = {
                          'name': name.text,
                          'lastname': last.text,
                          'tipodoc': tipodoc.text,
                          'doc': doc.text,
                        };
                        controlu.crearPerfil(userData);
                        Get.toNamed("/perfilUser");
                      }
                    },
                    // Aquí puedes validar las credenciales con tu backend
                    // y navegar a la siguiente pantalla si son correctas
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(10, 40)),
                      backgroundColor: MaterialStateProperty.all(Colors
                          .pink), // Cambia el color de fondo del botón a rojo
                      foregroundColor: MaterialStateProperty.all(Colors
                          .white), // Cambia el color del texto del botón a blanco
                    ),
                    child: const Text('Actualizar')),
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
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
