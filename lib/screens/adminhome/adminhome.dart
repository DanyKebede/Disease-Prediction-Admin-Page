import 'package:adminpage/screens/adminhome/doctorslist.dart';
import 'package:adminpage/screens/adminhome/hospitallist.dart';
import 'package:flutter/material.dart';

import '../../common/mydrawer.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(46, 67, 120, 1),
          elevation: 0,
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: const Color.fromRGBO(191, 181, 255, 1)),
                  shape: BoxShape.circle,
                ),
                width: 50,
                height: 50,
                child: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Admin",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Administrator",
                    style: TextStyle(
                      color: Color.fromRGBO(201, 197, 197, 1),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        endDrawer: draw(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(
                height: 3,
                color: Color.fromARGB(255, 163, 161, 161),
              ),
              titleBar("Doctors", context),
              const DoctorList(),
              titleBar("Hospitals", context),
              const HospitalList(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget titleBar(title, context) {
  return Container(
    margin: const EdgeInsets.only(right: 3, left: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'Inter', fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            if (title == 'Doctors') {
              Navigator.of(context).pushNamed('/doctorpage');
            } else if (title == 'Hospitals') {
              Navigator.of(context).pushNamed('/hospitalpage');
            }
          },
          child: const Text(
            "See All",
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
                decoration: TextDecoration.underline,
                color: Color.fromRGBO(204, 198, 198, 1)),
          ),
        ),
      ],
    ),
  );
}
