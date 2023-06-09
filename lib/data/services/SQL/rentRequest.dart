import 'dart:convert';
import 'package:ubnf/domain/models/rent.dart';
import 'package:ubnf/domain/models/message.dart';
import 'package:flutter/foundation.dart';
import 'package:ubnf/domain/models/property.dart';
import 'package:ubnf/domain/models/user.dart';
import 'package:http/http.dart' as http;

class RentRequest {
  static Future<List<Messages>> registerRent(
      int prop,
      int renter,
      String name,
      String address,
      DateTime inicDate,
      DateTime endDate,
      int visitors,
      int total) async {
    var url =
        Uri.parse("https://bamcdev.000webhostapp.com/ubnf/registrarRent.php");

    final response = await http.post(url, body: {
      'prop': prop.toString(),
      'renter': renter.toString(),
      'name': name,
      'address': address,
      'inicDate': inicDate.toString(),
      'endDate': endDate.toString(),
      'visitors': visitors.toString(),
      'total': total.toString()
    });

    print(response.statusCode);
    print(response.body);
    return compute(convertirAlista, response.body);
  }

  static Future<List<Messages>> deleteRent(int id) async {
    var url = Uri.parse("");

    final response = await http.post(url, body: {'id': id.toString()});

    return compute(convertirAlista, response.body);
  }

  static List<Messages> convertirAlista(String responsebody) {
    final convert = json.decode(responsebody).cast<Map<String, dynamic>>();
    print(convert);
    print(convert[0]['mensaje']);
    return convert.map<Messages>((json) => Messages.fromJson(json)).toList();
  }

  static Future<List<Rent>> getListRent() async {
    var url = Uri.parse("");

    final response = await http.get(url);

    print(response.statusCode);
    print(response.body);
    return compute(convertirAlista2, response.body);
  }

  static List<Rent> convertirAlista2(String responsebody) {
    final pasar = json.decode(responsebody).cast<Map<String, dynamic>>();
    return pasar.map<Rent>((json) => Rent.fromJson(json)).toList();
  }
}
