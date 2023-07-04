import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_house/models/farm.dart';
import 'package:green_house/models/plant.dart';
import 'package:green_house/models/sensors_reading.dart';
import 'package:green_house/utils/constants.dart';
import 'package:http/http.dart';

import '../presentation/widgets/app_popup.dart';

class FarmStore with ChangeNotifier {
  List<Farm> _allFarms = [];

  List<Farm> get allFarms {
    return _allFarms;
  }

  List<Plant> _allPlants = [];

  List<Plant> get allPlants {
    return _allPlants;
  }

  SensorsReadings? _sensorsReadings;

  SensorsReadings? get sensorsReadings {
    return _sensorsReadings;
  }

  Future<void> getAllFarms(BuildContext context, String token) async {
    try {
      Response response = await get(
        Uri.parse('$baseUrl/farms/getEverythingAboutUserFarms'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        _allFarms = List<Farm>.from(
            responseData['farms'].map((farm) => Farm.fromJson(farm)));
        notifyListeners();
      }
    } catch (e) {
      AppPopup.showMyDialog(context, e.toString());
    }
  }

  Future<bool> addPlantToFarm({
    required BuildContext context,
    required String plantName,
    required String serialNumber,
    required String plantsCount,
    required String token,
  }) async {
    try {
      Response response =
          await post(Uri.parse('$baseUrl/plants/addPlantToFarm'), headers: {
        'Authorization': 'Bearer $token'
      }, body: {
        "serialNumber": serialNumber,
        "plantName": plantName,
        "plant_count": plantsCount
      });
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        AppPopup.showMyDialog(context, response.body.toString());

        return false;
      }
    } catch (e) {
      AppPopup.showMyDialog(context, e.toString());
      return false;
    }
  }

  Future<bool> addFarm({
    required BuildContext context,
    required String farmName,
    required String serialNumber,
    required String token,
  }) async {
    try {
      Response response =
          await put(Uri.parse('$baseUrl/farms/addFarmToUser'), headers: {
        'Authorization': 'Bearer $token'
      }, body: {
        "serialNumber": serialNumber,
        "name": farmName,
      });
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        AppPopup.showMyDialog(context, response.body.toString());

        return false;
      }
    } catch (e) {
      AppPopup.showMyDialog(context, e.toString());
      return false;
    }
  }

  Future<void> getAllFarmPlants(
      BuildContext context, String token, String serialNumber) async {
    try {
      Response response = await post(
        Uri.parse('$baseUrl/plants/getAllPlantsByFarm'),
        body: {"serialNumber": serialNumber},
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        _allPlants = List<Plant>.from(
            responseData.map((plant) => Plant.fromJson(plant)));
        notifyListeners();
      } else {
        AppPopup.showMyDialog(context, response.body.toString());
      }
    } catch (e) {
      AppPopup.showMyDialog(context, e.toString());
    }
  }

  Future<void> getSensorsReadings(
      BuildContext context, String token, String serialNumber) async {
    try {
      Response response = await post(
        Uri.parse('$baseUrl/data/'),
        body: {"serialNumber": serialNumber},
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // print(responseData.last);

        _sensorsReadings = responseData.isEmpty
            ? SensorsReadings(
                eCo2: 0,
                eHumidity: 0,
                eTemp: 0,
                id: '',
                lightLvl: 0,
                serialNumber: '',
                tEc: 0,
                tPh: 0,
                tTemp: 0,
                tWaterLvl: 0)
            : SensorsReadings.fromJson(responseData.last);
        notifyListeners();
      }
    } catch (e) {
      AppPopup.showMyDialog(context, e.toString());
    }
  }
}
