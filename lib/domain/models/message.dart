class Messages {
  late String mensaje;

  Messages({required this.mensaje});

  factory Messages.fromJson(Map<String, dynamic> jsonMap) {
    return Messages(mensaje: jsonMap['message']);
  }
}
