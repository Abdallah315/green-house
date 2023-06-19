class Farm {
  String id;
  String name;
  List plants;

  Farm({required this.id, required this.name, required this.plants});

  factory Farm.fromJson(Map<String, dynamic> json) =>
      Farm(id: json['_id'], name: json['name'], plants: json['plants']);
}
