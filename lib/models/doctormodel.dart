import 'hospital.dart';

class DoctorModel {
  final int? id;
  final int age;
  final int hospital;
  final String name;
  final String phone;
  final String speciality;
  final String imgurl;
  final String title;
  final int experiance;
  final double rating;
  final String email;
  final int hours;
  final String? link; // ?

  DoctorModel({
    required this.age,
    required this.hospital,
    required this.name,
    required this.phone,
    required this.speciality,
    required this.imgurl,
    required this.title,
    required this.email,
    required this.experiance,
    required this.hours,
    required this.rating,
    this.link,
    this.id,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as int,
      age: json['age'] as int,
      title: json['title'] as String,
      name: json['name'] as String,
      hospital: json['hospital'] as int,
      phone: json['phone'] as String,
      speciality: json['specialty'] as String,
      imgurl: json['image'] != null ? json['image'] as String : '',
      email: json['email'] as String,
      experiance: json['experience'] as int,
      hours: json['hours'] as int,
      rating: double.parse(json['rating']),
      link:
          json['linkedin_link'] != null ? json['linkedin_link'] as String : '',
    );
  }

  Map<String, dynamic> toJson() => {
        'age': age,
        'hospital': hospital,
        'name': name,
        'phone': phone,
        'specialty': speciality,
        'image': imgurl,
        'title': title,
        'experience': experiance,
        'rating': rating,
        'email': email,
        'hours': hours,
        'linkedin_link': link,
      };
}
