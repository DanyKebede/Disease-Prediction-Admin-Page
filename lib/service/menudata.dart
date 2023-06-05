import 'package:flutter/material.dart';
import '../models/menumodel.dart';

final List<MenuModel> menuData = [
  MenuModel(
    title: 'Doctors',
    imgUrl: 'assets/images/doctor.png',
    boxColor: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromRGBO(248, 13, 253, 0.25),
        Color.fromRGBO(79, 68, 200, 1),
      ],
    ),
  ),
  MenuModel(
    title: 'Hospitals',
    imgUrl: 'assets/images/hospital.png',
    boxColor: const LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.bottomLeft,
      colors: [
        Color.fromRGBO(141, 134, 134, 0.81),
        Color.fromRGBO(161, 96, 96, 1),
      ],
    ),
  ),
  MenuModel(
    title: 'Change Password',
    imgUrl: 'assets/images/padlock.png',
    boxColor: const LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.bottomLeft,
      colors: [
        Color.fromRGBO(141, 134, 134, 0.81),
        Color.fromRGBO(161, 96, 96, 1),
      ],
    ),
  ),
  MenuModel(
    title: 'Logout',
    imgUrl: 'assets/images/logout.png',
    boxColor: const LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.bottomLeft,
      colors: [
        Color.fromRGBO(141, 134, 134, 0.81),
        Color.fromRGBO(161, 96, 96, 1),
      ],
    ),
  ),
];
