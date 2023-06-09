class User {
  late String name;
  late String lastname;
  late String tipodoc;
  late String doc;

  User({
    required this.name,
    required this.lastname,
    required this.tipodoc,
    required this.doc,
  });

  factory User.fromJson(Map<String, dynamic> jsonMap) {
    return User(
      name: jsonMap['name'],
      lastname: jsonMap['lastname'],
      tipodoc: jsonMap['tipodoc'],
      doc: jsonMap['cc'],
    );
  }
}
