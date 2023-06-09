import 'dart:convert';
import 'package:ubnf/domain/models/property.dart';
import 'package:ubnf/domain/models/message.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PropertyRequest {
  static Future<List<Messages>> registerProperty(
      int idOwner,
      String picture,
      String name,
      String address,
      String city,
      String descri,
      int price,
      int tax,
      int clean) async {
    var url =
        Uri.parse("https://bamcdev.000webhostapp.com/ubnf/registrarProp.php");

    final response = await http.post(url, body: {
      'picture': picture,
      'owner': idOwner.toString(),
      'name': name,
      'address': address,
      'city': city,
      'descri': descri,
      'price': price.toString(),
      'tax': tax.toString(),
      'clean': clean.toString()
    });

    print(response.statusCode);
    print(response.body);
    return compute(convertirAlista, response.body);
  }

  static Future<List<Messages>> updateProperty(
      int id,
      String picture,
      String name,
      String address,
      String city,
      String descri,
      int price,
      int tax,
      int clean) async {
    var url = Uri.parse("");

    final response = await http.post(url, body: {
      'id': id.toString(),
      'picture': picture,
      'name': name,
      'address': address,
      'city': city,
      'descri': descri,
      'price': price.toString(),
      'tax': tax.toString(),
      'clean': clean
    });

    return compute(convertirAlista, response.body);
  }

  static Future<List<Messages>> deleteProperty(int id) async {
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

  static Future<List<Property>> getListProperty() async {
    var url =
        Uri.parse("https://bamcdev.000webhostapp.com/ubnf/listaProps.php");

    final response = await http.get(url);

    print(response.statusCode);
    print(response.body);
    return compute(convertirAlista2, response.body);
  }

  static List<Property> convertirAlista2(String responsebody) {
    final pasar = json.decode(responsebody).cast<Map<String, dynamic>>();
    return pasar.map<Property>((json) => Property.fromJson(json)).toList();
  }
}
