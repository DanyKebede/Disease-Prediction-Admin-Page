class HospitalModel {
  final int? id;
  final String name;
  final String phone;
  final String location;
  final String imgurl;
  final double lat;
  final double lng;
  final double rating;
  final String email;
  final int hours;

  const HospitalModel({
    this.id,
    required this.name,
    required this.phone,
    required this.imgurl,
    required this.email,
    required this.hours,
    required this.rating,
    required this.lat,
    required this.lng,
    this.location = "Bahir Dar, Ethiopia",
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      imgurl: json['image'] != null ? json['image'] as String : '',
      location: json['address'],
      email: json['email'] as String,
      lng: double.parse(json['longitude']),
      lat: double.parse(json['latitude']),
      hours: json['openhours'] as int,
      rating: double.parse(json['rating']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'image': imgurl,
        'address': location,
        'latitude': lat,
        'longitude': lng,
        'rating': rating,
        'email': email,
        'openhours': hours,
      };
}
