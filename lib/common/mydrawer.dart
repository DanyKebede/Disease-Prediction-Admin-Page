import 'package:adminpage/provider/adminprovider.dart';
import 'package:flutter/material.dart';
import '../service/menudata.dart';

Widget draw(context) {
  return Drawer(
    backgroundColor: const Color.fromRGBO(46, 67, 120, 1),
    child: Column(
      children: menuData
          .map(
            (e) => Card(
              elevation: 0,
              color: const Color.fromRGBO(46, 67, 120, 1),
              child: ListTile(
                title: Text(
                  e.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter'),
                ),
                leading: Image.asset(
                  e.imgUrl,
                  width: 40,
                  height: 40,
                ),
                onTap: () {
                  if (e.title == 'Doctors') {
                    Navigator.of(context).popAndPushNamed('/doctorpage');
                  } else if (e.title == 'Hospitals') {
                    Navigator.of(context).popAndPushNamed('/hospitalpage');
                  } else if (e.title == 'Logout') {
                    AdminApi.logout();
                    Navigator.pushReplacementNamed(context, '/adminlogin');
                  } else if (e.title == 'Change Password') {
                    Navigator.of(context).popAndPushNamed('/change_password');
                  }
                },
              ),
            ),
          )
          .toList(),
    ),
  );
}
