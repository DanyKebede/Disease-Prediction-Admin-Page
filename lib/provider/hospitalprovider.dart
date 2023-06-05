import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/hospital.dart';
import './adminprovider.dart';

class HospitalProvider extends ChangeNotifier {
  List<dynamic> hospitaldata = [];
  List<dynamic> searchResult = [];

  void deleteHospitalByid(int id) async {
    try {
      await deleteHospital(id);
      loadHospitals();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting Hospital: $e');
      }
    }
  }

  Future<void> deleteHospital(int id) async {
    final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/hospitals/$id/'),
        headers: {'Authorization': 'Token ${AdminApi.authToken ?? ''}'});
    if (response.statusCode != 204) {
      throw Exception('Failed to delete Hospital');
    }
  }

  Future<void> updateHospital(HospitalModel hospitaldata) async {
    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:8000/hospitals/${hospitaldata.id}/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ${AdminApi.authToken ?? ''}'
        },
        body: jsonEncode(hospitaldata.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        loadHospitals();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error Updating Hospital: $e');
      }
    }
  }

  Future<dynamic> fetchHospitalById(int id) async {
    final hospitaldata = await http.get(
        Uri.parse('http://10.0.2.2:8000/hospitals/$id'),
        headers: {'Authorization': 'Token ${AdminApi.authToken ?? ''}'});
    final data = await json.decode(hospitaldata.body);
    return HospitalModel.fromJson(data);
  }

  Future<void> loadHospitals() async {
    try {
      final hospitals = await fetchHospitals();
      hospitaldata = hospitals;
      searchResult = hospitals;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading Hospital: $e');
      }
    }

    notifyListeners();
  }

  Future<List<dynamic>> fetchHospitals() async {
    final hospitaldata = await http.get(
        Uri.parse('http://10.0.2.2:8000/hospitals/'),
        headers: {'Authorization': 'Token ${AdminApi.authToken ?? ''}'});
    final List<dynamic> data = await json.decode(hospitaldata.body);

    return data.map((json) => HospitalModel.fromJson(json)).toList();
  }

  Future<void> registerHospital(HospitalModel hospitaldata) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/hospitals/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ${AdminApi.authToken ?? ''}'
        },
        body: jsonEncode(hospitaldata.toJson()),
      );
      if (response.statusCode == 201) {
        loadHospitals();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error registering Hospital: $e');
      }
    }
  }

  search(val) {
    if (val == '') {
      searchResult = hospitaldata;
    } else {
      searchResult = hospitaldata
          .where((element) =>
              element.name.toLowerCase().contains(val.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
