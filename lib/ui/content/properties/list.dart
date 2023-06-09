import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:ubnf/domain/controllers/Firebase/controllerUser.dart';

import '../../../domain/controllers/Firebase/controllerProp.dart';

class PropList extends StatefulWidget {
  const PropList({super.key});

  @override
  State<PropList> createState() => PropListState();
}

class PropListState extends State<PropList> {
  final drawer = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    ControlUserAuth controlus = Get.find();
    ControlProp controlp = Get.find();
    return AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
            ),
          ),
        ),
        controller: drawer,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        // openScale: 1.0,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 0.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: SafeArea(
          child: Container(
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 128.0,
                    height: 128.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 64.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  // ListTile(
                  //   onTap: () {},
                  //   leading: const Icon(Icons.home),
                  //   title: const Text('Home'),
                  // ),
                  ListTile(
                    onTap: () {
                      Get.toNamed("/perfilUser");
                    },
                    leading: const Icon(Icons.account_circle_rounded),
                    title: const Text('Perfil'),
                  ),
                  ListTile(
                    onTap: () {
                      controlp
                          .listPropUser()
                          .then((value) => Get.toNamed("/userPlaces"));
                    },
                    leading: const Icon(Icons.home_rounded),
                    title: const Text('Mis Lugares'),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed("/props");
                    },
                    leading: const Icon(Icons.add_home_rounded),
                    title: const Text('Registrar Lugar'),
                  ),

                  ListTile(
                    onTap: () {
                      controlus.logout().then((value) {
                        Get.snackbar("Usuarios", controlus.mensajesUser,
                            duration: const Duration(seconds: 4),
                            backgroundColor: Colors.blueAccent,
                            colorText: Colors.white);
                        Get.toNamed("/login");
                      });
                    },
                    leading: const Icon(Icons.logout),
                    title: const Text('Cerrar sesión'),
                  ),
                  const Spacer(),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: const Text('Terms of Service | Privacy Policy'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        child: Scaffold(
            appBar: AppBar(
              title: const Text("UBNF"),
              backgroundColor: Colors.blueAccent,
              leading: IconButton(
                onPressed: () {
                  drawer.showDrawer();
                },
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: drawer,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
            ),
            body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controlp.listProperty,
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
                                            style:
                                                const TextStyle(fontSize: 14.0),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            "COP: ${propsData['price']}",
                                            style:
                                                const TextStyle(fontSize: 12.0),
                                          ),
                                          const SizedBox(height: 16.0),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.toNamed("/rents", arguments: [
                                                propsId.id,
                                                propsData['name'],
                                                propsData['address'],
                                                propsData['city'],
                                                propsData['price'],
                                                propsData['tax'],
                                                propsData['clean'],
                                                propsData['foto'],

                                                //   controlp
                                                //       .listProperty![index].id,
                                                //   controlp
                                                //       .listProperty![index].name,
                                                //   controlp.listProperty![index]
                                                //       .address,
                                                //   controlp
                                                //       .listProperty![index].price,
                                                //   controlp
                                                //       .listProperty![index].tax,
                                                //   controlp
                                                //       .listProperty![index].clean,
                                                //   controlp.listProperty![index]
                                                //       .picture,
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
                                            child: const Text('Alquilar Ahora'),
                                          ),
                                          const SizedBox(height: 16.0),
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
                })));
  }
}
