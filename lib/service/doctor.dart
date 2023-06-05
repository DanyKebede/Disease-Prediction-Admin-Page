// import '../models/doctormodel.dart';
// import './hospital.dart';

// List<DoctorModel> doctorData = const [
//   DoctorModel(
//       age: 43,
//       hospital: 1,
//       // hospital: [
//       //   'Dream care General Hospital',
//       // ],
//       name: 'Bereket Asefa',
//       phone: '090909090909',
//       location: 'psychiatrist',
//       imgurl:
//           'https://images.unsplash.com/photo-1582750433449-648ed127bb54?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzN8fGRvY3RvcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
//       email: 'bereket@gmail.com',
//       experiance: 13,
//       hours: 8,
//       rating: 4.2,
//       title: 'Dr.',
//       link: 'linkedin.com/in/yitayih-berhane-076b0676'),
//   DoctorModel(
//       age: 36,
//       hospital: 2,
//       name: 'Abebe Teferi',
//       phone: '090409090909',
//       location: 'Anesthesiology',
//       imgurl:
//           'https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8ZG9jdG9yfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
//       email: 'abebe@gmail.com',
//       experiance: 8,
//       hours: 8,
//       rating: 3.8,
//       title: 'Dr.',
//       link: 'linkedin.com/in/yitayih-berhane-076b0676'),
//   DoctorModel(
//     age: 30,
//     hospital: 1,
//     name: 'Aster Jhon',
//     phone: '0901010101',
//     location: 'Pathology',
//     imgurl:
//         'https://images.unsplash.com/photo-1551884170-09fb70a3a2ed?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGRvY3RvcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
//     email: 'aster@gmail.com',
//     experiance: 6,
//     hours: 7,
//     rating: 4.0,
//     title: 'Dr.',
//   ),
//   DoctorModel(
//     age: 39,
//     hospital: 0,
//     name: 'Yonatan Keflu',
//     phone: '090909090909',
//     location: 'psychiatrist',
//     imgurl:
//         'https://images.pexels.com/photos/4989166/pexels-photo-4989166.jpeg?auto=compress&cs=tinysrgb&w=600',
//     email: 'yonatan@gmail.com',
//     experiance: 10,
//     hours: 9,
//     rating: 4.3,
//     title: 'Dr.',
//   )
// ];

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/doctormodel.dart';

List<dynamic> doctorData = [];

Future<void> loadDoctors() async {
  try {
    final doctors = await fetchDoctors();
    doctorData = doctors;
  } catch (e) {
    if (kDebugMode) {
      print('Error loading doctors: $e');
    }
  }
}

Future<List<dynamic>> fetchDoctors() async {
  final doctorData =
      await http.get(Uri.parse('http://127.0.0.1:8000/doctors/'));
  final List<dynamic> data = await json.decode(doctorData.body);
  return data.map((json) => DoctorModel.fromJson(json)).toList();
}

Future<void> registerDoctor(DoctorModel doctorData) async {
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/doctors/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(doctorData.toJson()),
    );
    if (response.statusCode == 201) {}
  } catch (e) {
    if (kDebugMode) {
      print('Error registering doctor: $e');
    }
  }
}
