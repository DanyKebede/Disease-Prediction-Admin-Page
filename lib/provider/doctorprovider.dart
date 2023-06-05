import 'package:flutter/foundation.dart';
import 'dart:convert';

import './adminprovider.dart';
import '../models/doctormodel.dart';
import 'package:http/http.dart' as http;

class DoctorProvider extends ChangeNotifier {
  List<dynamic> doctorData = [];
  List<dynamic> searchResult = [];

  void deleteDoctorByid(int id) async {
    try {
      await deleteDoctor(id);
      loadDoctors();
      // print('Deleted doctor with ID: $id');
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting doctor: $e');
      }
    }
  }

  Future<void> deleteDoctor(int id) async {
    final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/doctors/$id/'),
        headers: {'Authorization': 'Token ${AdminApi.authToken ?? ''}'});
    if (response.statusCode != 204) {
      throw Exception('Failed to delete doctor');
    }
  }

  Future<void> updateDoctor(DoctorModel doctorData) async {
    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:8000/doctors/${doctorData.id}/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ${AdminApi.authToken ?? ''}'
        },
        body: jsonEncode(doctorData.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        loadDoctors();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error Updating doctor: $e');
      }
    }
  }

  Future<dynamic> fetchDoctorById(int id) async {
    final doctorData = await http.get(
        Uri.parse('http://10.0.2.2:8000/doctors/$id'),
        headers: {'Authorization': 'Token ${AdminApi.authToken ?? ''}'});
    final data = await json.decode(doctorData.body);
    return DoctorModel.fromJson(data);
  }

  Future<void> loadDoctors() async {
    try {
      final doctors = await fetchDoctors();
      doctorData = doctors;
      searchResult = doctors;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading doctors: $e');
      }
    }

    notifyListeners();
  }

  Future<List<dynamic>> fetchDoctors() async {
    final doctorData = await http.get(
        Uri.parse('http://10.0.2.2:8000/doctors/'),
        headers: {'Authorization': 'Token ${AdminApi.authToken ?? ''}'});
    final List<dynamic> data = await json.decode(doctorData.body);
    return data.map((json) => DoctorModel.fromJson(json)).toList();
  }

  Future<void> registerDoctor(DoctorModel doctorData) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/doctors/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ${AdminApi.authToken ?? ''}'
        },
        body: jsonEncode(doctorData.toJson()),
      );
      if (response.statusCode == 201) {
        loadDoctors();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error registering doctor: $e');
      }
    }
  }

  search(val) {
    if (val == '') {
      searchResult = doctorData;
    } else {
      searchResult = doctorData
          .where((element) =>
              element.name.toLowerCase().contains(val.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
