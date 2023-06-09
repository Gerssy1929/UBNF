class Rent {
  late int id;
  late int idProp;
  late int idRenter;
  late String name;
  late String address;
  late DateTime inicDate;
  late DateTime endDate;
  late int visitors;
  late int total;

  Rent(
      {required this.id,
      required this.idProp,
      required this.idRenter,
      required this.name,
      required this.address,
      required this.inicDate,
      required this.endDate,
      required this.visitors,
      required this.total});

  factory Rent.fromJson(Map<String, dynamic> jsonMap) {
    return Rent(
        id: int.parse(jsonMap['id']),
        idProp: int.parse(jsonMap['prop']),
        idRenter: int.parse(jsonMap['renter']),
        name: (jsonMap['name']),
        address: (jsonMap['address']),
        inicDate: DateTime.parse(jsonMap['inicDate']),
        endDate: DateTime.parse(jsonMap['endDate']),
        visitors: int.parse(jsonMap['visitors']),
        total: int.parse(jsonMap['total']));
  }
}
