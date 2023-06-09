import 'package:ubnf/data/services/SQL/rentRequest.dart';
import 'package:ubnf/domain/models/rent.dart';
import 'package:ubnf/domain/models/message.dart';
import 'package:get/get.dart';

class ControlRent extends GetxController {
  final Rxn<List<Messages>> _listMessages = Rxn<List<Messages>>([]);
  final Rxn<List<Rent>> _listRent = Rxn<List<Rent>>([]);

  Future<void> crearRent(int prop, int renter, String name, String address,
      DateTime inicDate, DateTime endDate, int visitors, int total) async {
    _listMessages.value = await RentRequest.registerRent(
        prop, renter, name, address, inicDate, endDate, visitors, total);
  }

  Future<void> deleteRent(int id) async {
    _listMessages.value = await RentRequest.deleteRent(id);
  }

  Future<void> getlistRent() async {
    _listRent.value = await RentRequest.getListRent();
  }

  List<Messages>? get listMessages => _listMessages.value;
  List<Rent>? get listRent => _listRent.value;
}
