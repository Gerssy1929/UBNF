import 'dart:convert';
import 'package:ubnf/domain/models/user.dart';
import 'package:ubnf/domain/models/message.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserRequest {
  static Future<List<Messages>> registerUser(
      String email,
      String pass,
      String name,
      String lastname,
      String tipodoc,
      String doc,
      String card,
      String cvv) async {
    var url =
        Uri.parse("https://bamcdev.000webhostapp.com/ubnf/registrarUser.php");

    final response = await http.post(url, body: {
      'email': email,
      'pass': pass,
      'name': name,
      'lastname': lastname,
      'tipodoc': tipodoc,
      'doc': doc,
      'card': card,
      'cvv': cvv
    });

    print(response.statusCode);
    print(response.body);
    return compute(convertirAlista, response.body);
  }

  static Future<List<Messages>> updateUser(
      int id,
      String email,
      String name,
      String lastname,
      String tipodoc,
      String doc,
      String card,
      String cvv) async {
    var url = Uri.parse("");

    final response = await http.post(url, body: {
      'id': id.toString(),
      'email': email,
      'name': name,
      'lastname': lastname,
      'tipodoc': tipodoc,
      'doc': doc,
      'card': card,
      'cvv': cvv
    });

    return compute(convertirAlista, response.body);
  }

  static Future<List<Messages>> deleteUser(int id) async {
    var url = Uri.parse("");

    final response = await http.post(url, body: {'id': id.toString()});

    return compute(convertirAlista, response.body);
  }

  static List<Messages> convertirAlista(String responsebody) {
    final pasar = json.decode(responsebody).cast<Map<String, dynamic>>();
    return pasar.map<Messages>((json) => Messages.fromJson(json)).toList();
  }

  static Future<List<User>> validarUser(String email, String pass) async {
    var url =
        Uri.parse("https://bamcdev.000webhostapp.com/ubnf/validarUser.php");

    final response = await http.post(url, body: {'email': email, 'pass': pass});

    return compute(convertirAlista2, response.body);
  }

  static List<User> convertirAlista2(String responsebody) {
    final pasar = json.decode(responsebody).cast<Map<String, dynamic>>();
    return pasar.map<User>((json) => User.fromJson(json)).toList();
  }
}
