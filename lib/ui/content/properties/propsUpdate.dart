import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validatorless/validatorless.dart';
import 'package:http/http.dart' as http;

import '../../../domain/controllers/Firebase/controllerProp.dart';
import '../../../domain/controllers/Firebase/controllerUser.dart';

class PropUpdate extends StatefulWidget {
  const PropUpdate({super.key});

  @override
  State<PropUpdate> createState() => _PropUpdateState();
}

class _PropUpdateState extends State<PropUpdate> {
  final _formKey = GlobalKey<FormState>();
  final args = Get.arguments;

  ImagePicker picker = ImagePicker();
  var _image;

  _galeria() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() async {
      _image = (image != null) ? File(image.path) : null;
      //_image = File(image!.path);
    });
  }

  _camara() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() async {
      _image = (image != null) ? File(image.path) : null;

      // _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    ControlProp controlp = Get.find();
    ControlUserAuth controlu = Get.find();

    late String owner = controlu.userValido!.user!.uid;
    late String id = args[0];
    late dynamic foto = args[8];

    // late String name = args[0];
    // late String last = args[1];
    // late String tipodoc = args[2];
    // late String doc = args[3];

    TextEditingController name = TextEditingController();
    TextEditingController add = TextEditingController();
    TextEditingController city = TextEditingController();
    TextEditingController descri = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController tax = TextEditingController();
    TextEditingController clean = TextEditingController();

    name.text = args[1];
    add.text = args[2];
    city.text = args[3];
    descri.text = args[4];
    price.text = args[5].toString();
    tax.text = args[6].toString();
    clean.text = args[7].toString();

    return Scaffold(
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      right: 35,
                      left: 35,
                      top: MediaQuery.of(context).size.height * 0),
                  child: Column(
                    children: [
                      Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 56, 0, 0),
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text('Actualiza tu lugar...',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17.0)),
                          ],
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _opcioncamara(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            height: 150,
                            width: double.maxFinite,
                            child: Card(
                                elevation: 5,
                                child: _image != null
                                    ? Image.file(
                                        _image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                      )
                                    : Image.network(
                                        foto,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                      )),
                          ),
                        ),
                      ),
                      const SizedBox(height: 0.0),
                      TextFormField(
                        controller: name,
                        style: const TextStyle(
                            // Cambia el color del texto a azul
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\d')),
                        ],
                        decoration: const InputDecoration(
                            labelText: 'Nombre',
                            hintText: 'Nombre del lugar',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                            focusColor: Colors.deepPurpleAccent),
                        validator: Validatorless.multiple([
                          Validatorless.required('El campo es obligatorio')
                        ]),
                        // onSaved: (value) {
                        //   name = value!;
                        // },
                      ),
                      const SizedBox(height: 0.0),
                      TextFormField(
                        controller: add,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Dirección',
                          hintText: 'Ubicación del lugar...',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.required('El campo es obligatorio')
                        ]),
                        // onSaved: (value) {
                        //   address = value!;
                        // },
                      ),
                      const SizedBox(height: 0.0),
                      TextFormField(
                        controller: city,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\d')),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Ciudad',
                          hintText: 'Ciudad...',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.required('El campo es obligatorio')
                        ]),
                        // onSaved: (value) {
                        //   city = value!;
                        // },
                      ),
                      const SizedBox(height: 0.0),
                      TextFormField(
                        controller: descri,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Descripción',
                          hintText: 'Describenos tu lugar...',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.required('El campo es obligatorio')
                        ]),
                        // onSaved: (value) {
                        //   descri = value!;
                        // },
                      ),
                      const SizedBox(height: 0.0),
                      TextFormField(
                        controller: price,
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Precio',
                          hintText: 'Precio por noche...',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.number("Ingrese un valor"),
                          Validatorless.required('El campo es obligatorio')
                        ]),
                        // onSaved: (value) {
                        //   price = int.parse(value!);
                        // },
                      ),
                      const SizedBox(height: 0.0),
                      TextFormField(
                        controller: tax,
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Impuestos',
                          hintText: 'Impuestos por estadia...',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.number("Ingrese un valor"),
                          Validatorless.required('El campo es obligatorio')
                        ]),
                        // onSaved: (value) {
                        //   tax = int.parse(value!);
                        // },
                      ),
                      const SizedBox(height: 0.0),
                      TextFormField(
                        controller: clean,
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Limpieza',
                          hintText: 'Recargo por limpieza...',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.number("Ingrese un valor"),
                          Validatorless.required('El campo es obligatorio')
                        ]),
                        // onSaved: (value) {
                        //   clean = int.parse(value!);
                        // },
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Map<String, dynamic> propData = {
                                'owner': owner,
                                'name': name.text,
                                'address': add.text,
                                'city': city.text,
                                'descri': descri.text,
                                'price': int.parse(price.text),
                                'tax': int.parse(tax.text),
                                'clean': int.parse(clean.text),
                              };
                              controlp.updateProp(id, propData, _image);
                              controlp
                                  .listPropUser()
                                  .then((value) => Get.toNamed("/userPlaces"));
                            }
                          },
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(10, 40)),
                            backgroundColor: MaterialStateProperty.all(Colors
                                .blueAccent), // Cambia el color de fondo del botón a rojo
                            foregroundColor: MaterialStateProperty.all(Colors
                                .white), // Cambia el color del texto del botón a blanco
                          ),
                          child: const Text('Actualizar Propiedad')),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                controlp
                                    .listProp()
                                    .then((value) => Get.toNamed("/places"));
                              },
                              child: const Text(
                                'Home',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Color(0xff4c505b),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  onPressed: () {
                                    controlp.listPropUser().then(
                                        (value) => Get.toNamed("/userPlaces"));
                                  }),
                            )
                          ])
                    ],
                  )),
            )));
  }

  void _opcioncamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Imagen de Galeria'),
                      onTap: () {
                        _galeria();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Capturar Imagen'),
                    onTap: () {
                      _camara();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
