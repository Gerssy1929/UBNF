import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/Firebase/controllerProp.dart';

class UserPlaces extends StatefulWidget {
  const UserPlaces({super.key});

  @override
  State<UserPlaces> createState() => _UserPlacesState();
}

class _UserPlacesState extends State<UserPlaces> {
  ControlProp controlp = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mis Lugares"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              controlp.listProp().then((value) => Get.toNamed("/places"));
            },
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controlp.listPropertyUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final props = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: props.length,
                  itemBuilder: (BuildContext context, int index) {
                    final propsData = props[index].data();
                    final propsId = props[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: SizedBox(
                        width: 150.0,
                        child: Card(
                          margin: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AspectRatio(
                                  aspectRatio: 4 / 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      propsData['foto'],
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        propsData['name'],
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        propsData['descri'],
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        "COP: ${propsData['price']}",
                                        style: const TextStyle(fontSize: 12.0),
                                      ),
                                      const SizedBox(height: 16.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.toNamed("/updatePlace",
                                              arguments: [
                                                propsId.id,
                                                propsData['name'],
                                                propsData['address'],
                                                propsData['city'],
                                                propsData['descri'],
                                                propsData['price'],
                                                propsData['tax'],
                                                propsData['clean'],
                                                propsData['foto'],
                                              ]);
                                        },
                                        style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  const Size(10, 40)),
                                          backgroundColor:
                                              MaterialStateProperty.all(Colors
                                                  .pink), // Cambia el color de fondo del botón a rojo
                                          foregroundColor:
                                              MaterialStateProperty.all(Colors
                                                  .white), // Cambia el color del texto del botón a blanco
                                        ),
                                        child: const Text('Actualizar Lugar'),
                                      ),
                                      const SizedBox(height: 16.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          mostrarConfirmacion(
                                              context, propsId.id);
                                        },
                                        style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  const Size(10, 40)),
                                          backgroundColor:
                                              MaterialStateProperty.all(Colors
                                                  .pink), // Cambia el color de fondo del botón a rojo
                                          foregroundColor:
                                              MaterialStateProperty.all(Colors
                                                  .white), // Cambia el color del texto del botón a blanco
                                        ),
                                        child: const Text('Eliminar Lugar'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return const Text('Error al obtener los datos');
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  void mostrarConfirmacion(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Desea eliminar la propiedad?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // Color del texto del botón
                backgroundColor: Colors.white, // Color de fondo del botón
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent, // Color del texto del botón
                backgroundColor: Colors.white, // Color de fondo del botón
              ),
              onPressed: () {
                controlp.deleteProp(id);
                // Realizar la operación
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
