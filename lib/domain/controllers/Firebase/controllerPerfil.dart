import 'package:get/get.dart';
import 'package:ubnf/data/services/Firebase/fireUser2.dart';

class ControlUserPerfil extends GetxController {
  final _response = Rxn();

  Future<void> crearPerfil(Map<String, dynamic> user) async {
    await Peticiones.perfil(user);
  }

  Future<Map<String, dynamic>> getPerfil() async {
    Map<String, dynamic> data = await Peticiones.getPerfil();
    print(data);
    return data;
  }
}
