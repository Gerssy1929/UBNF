import 'package:get/get.dart';
import 'package:ubnf/data/services/Firebase/fireRent.dart';

class ControllerRent extends GetxController {
  Future<void> crearRent(Map<String, dynamic> rent) async {
    await PeticionesRent.crearRent(rent);
  }
}
