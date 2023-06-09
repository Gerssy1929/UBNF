import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ubnf/domain/controllers/Firebase/controllerPerfil.dart';

import '../../../domain/controllers/Firebase/controllerProp.dart';

class PerfilUser extends StatefulWidget {
  const PerfilUser({super.key});

  @override
  State<PerfilUser> createState() => _PerfilUserState();
}

class _PerfilUserState extends State<PerfilUser> {
  ControlUserPerfil controlup = Get.find();
  ControlProp controlp = Get.find();

  late String name = '';
  late String last = '';
  late String tipo = '';
  late String doc = '';

  @override
  void initState() {
    super.initState();
    // Aquí obtendrías los datos del documento de Firestore y los asignarías a las variables
    loadDataFromFirestore();
  }

  void loadDataFromFirestore() async {
    Map<String, dynamic> datos = await controlup.getPerfil();
    setState(() {
      name = datos['name'];
      last = datos['lastname'];
      tipo = datos['tipodoc'];
      doc = datos['doc'];
    });
    // Aquí se realiza la consulta a Firestore para obtener los datos del documento
    // y se asignan a las variables correspondientes (data1, data2, data3, data4)
    // Puedes utilizar el paquete cloud_firestore para interactuar con Firestore
    // y Firebase.initializeApp() para inicializar Firebase en tu aplicación Flutter.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos Personales'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            controlp.listProp().then((value) => Get.toNamed("/places"));
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: 250,
              height: 70,
              color: Colors.blueAccent,
              child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.person,
                      color: Colors.white), // Icono al principio
                  const SizedBox(width: 8),
                  Text(
                    'Nombre: $name',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: 250,
              height: 70,
              color: Colors.blueAccent,
              child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.person,
                      color: Colors.white), // Icono al principio
                  const SizedBox(width: 8),
                  Text(
                    'Apellido: $last',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: 260,
              height: 70,
              color: Colors.blueAccent,
              child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.edit_document,
                      color: Colors.white), // Icono al principio
                  const SizedBox(width: 8),
                  Text(
                    'Tipo Documento: $tipo',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: 320,
              height: 70,
              color: Colors.blueAccent,
              child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.edit_document,
                      color: Colors.white), // Icono al principio
                  const SizedBox(width: 8),
                  Text(
                    '# Documento: $doc',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/perfilUpdate", arguments: [
                      name,
                      last,
                      tipo,
                      doc,
                    ]);

                    // Acción a realizar al presionar el botón
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.pink, // Cambiar el color de fondo del botón
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15), // Cambiar el tamaño del botón
                  ),
                  child: const Text(
                    'Actualizar Datos',
                    style: TextStyle(
                      fontSize: 20, // Cambiar el tamaño del texto del botón
                      color:
                          Colors.white, // Cambiar el color del texto del botón
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                ElevatedButton(
                  onPressed: () {
                    controlp.listProp().then((value) => Get.toNamed("/places"));

                    // Acción a realizar al presionar el botón
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.pink, // Cambiar el color de fondo del botón
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15), // Cambiar el tamaño del botón
                  ),
                  child: const Text(
                    'Lugares',
                    style: TextStyle(
                      fontSize: 20, // Cambiar el tamaño del texto del botón
                      color:
                          Colors.white, // Cambiar el color del texto del botón
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
