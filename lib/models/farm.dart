class Farm {
  String id;
  String name;
  String serialNumber;
  List plants;

  Farm(
      {required this.id,
      required this.name,
      required this.plants,
      required this.serialNumber});

  factory Farm.fromJson(Map<String, dynamic> json) => Farm(
      id: json['_id'],
      name: json['name'],
      plants: json['plants'],
      serialNumber: json['serialNumber']);
}
