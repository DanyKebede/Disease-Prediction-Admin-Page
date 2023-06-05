import 'package:adminpage/provider/doctorprovider.dart';
import 'package:adminpage/provider/hospitalprovider.dart';
import 'package:adminpage/screens/adminhome/adminhome.dart';
import 'package:adminpage/screens/adminloginPage/admin.dart';
import 'package:adminpage/screens/adminloginPage/changepassword.dart';
import 'package:adminpage/screens/doctorspage/doctorform.dart';
import 'package:adminpage/screens/doctorspage/doctorpage.dart';
import 'package:adminpage/screens/hospitalspage/hospitalform.dart';
import 'package:adminpage/screens/hospitalspage/hospitalspage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AdminPage());
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DoctorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HospitalProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  width: 1, color: Color.fromRGBO(220, 212, 212, 1)),
            ),
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(46, 67, 120, 1),
          textTheme: const TextTheme(
            titleMedium: TextStyle(color: Colors.white, fontFamily: 'Inter'),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const AdminLogInPage(),
        routes: {
          '/adminlogin': (context) => const AdminLogInPage(),
          '/home': (context) => const AdminHomePage(),
          '/doctorpage': (context) => const DoctorsPage(),
          '/doctoradd': (context) => const AddDoctorForm(),
          '/hospitalpage': (context) => const HospitalsPage(),
          '/hospitaladd': (context) => const AddHospitalForm(),
          '/change_password': (context) => const ChangePasswordScreen(),
        },
      ),
    );
  }
}
