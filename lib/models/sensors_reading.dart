class SensorsReadings {
  String id;
  String serialNumber;
  dynamic tTemp;
  dynamic eTemp;
  dynamic eCo2;
  dynamic lightLvl;
  dynamic eHumidity;
  dynamic tWaterLvl;
  dynamic tPh;
  dynamic tEc;

  SensorsReadings(
      {required this.eCo2,
      required this.eHumidity,
      required this.eTemp,
      required this.id,
      required this.lightLvl,
      required this.serialNumber,
      required this.tEc,
      required this.tPh,
      required this.tTemp,
      required this.tWaterLvl});

  factory SensorsReadings.fromJson(Map<String, dynamic> json) =>
      SensorsReadings(
        id: json['_id'],
        serialNumber: json['serialNumber'],
        tTemp: json['T_temperature'],
        eTemp: json['E_temperature'],
        eCo2: json['E_co2'],
        lightLvl: json['E_lightLVL'],
        eHumidity: json['E_humidity'],
        tWaterLvl: json['T_Waterlvl'],
        tPh: json['T_PH'],
        tEc: json['T_EC'],
      );
}

    // {
    //     "_id": "64a1fc29c929f3bafc2262ed",
    //     "farmID": "6460a15a5cce1e0273bea005",
    //     "serialNumber": "hCsdkfjcx2",
    //     "paired": false,
    //     "T_temperature": 28.4375,
    //     "E_temperature": 37,
    //     "E_co2": 2.817372561,
    //     "E_lightLVL": 0,
    //     "E_humidity": 38.09999847,
    //     "T_Waterlvl": 0,
    //     "T_PH": 19,
    //     "T_EC": 5,
    //     "createdAt": "2023-07-02T22:37:29.624Z",
    //     "updatedAt": "2023-07-02T22:37:29.624Z",
    //     "__v": 0
    // }