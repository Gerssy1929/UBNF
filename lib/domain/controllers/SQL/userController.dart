import 'package:ubnf/data/services/SQL/userRequest.dart';
import 'package:ubnf/domain/models/user.dart';
import 'package:ubnf/domain/models/message.dart';
import 'package:get/get.dart';

class ControlUser extends GetxController {
  final Rxn<List<Messages>> _listMessages = Rxn<List<Messages>>([]);
  final Rxn<List<User>> _listUser = Rxn<List<User>>([]);

  Future<void> createUser(
      String email,
      String pass,
      String name,
      String lastname,
      String tipodoc,
      String doc,
      String card,
      String cvv) async {
    _listMessages.value = await UserRequest.registerUser(
        email, pass, name, lastname, tipodoc, doc, card, cvv);
  }

  Future<void> validarUser(String email, String pass) async {
    _listUser.value = await UserRequest.validarUser(email, pass);
  }

  Future<void> deleteUser(int id) async {
    _listMessages.value = await UserRequest.deleteUser(id);
  }

  Future<void> updateUser(int id, String email, String name, String lastname,
      String tipodoc, String doc, String card, String cvv) async {
    _listMessages.value = await UserRequest.updateUser(
        id, email, name, lastname, tipodoc, doc, card, cvv);
  }

  List<Messages>? get listMessages => _listMessages.value;
  List<User>? get listaUserLogin => _listUser.value;
}
