class Plant {
  String name;
  int plantCount;
  String harvestDate;

  Plant(
      {required this.harvestDate,
      required this.name,
      required this.plantCount});

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
      plantCount: json['plant_count'],
      name: json['name'],
      harvestDate: json['harvest_date']);
}
