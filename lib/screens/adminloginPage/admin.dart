import 'package:adminpage/provider/adminprovider.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminLogInPage extends StatefulWidget {
  const AdminLogInPage({super.key});

  @override
  State<AdminLogInPage> createState() => _AdminLogInPageState();
}

class _AdminLogInPageState extends State<AdminLogInPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  void _login() async {
    if (usernameController.text == '' || passwordController.text == '') return;
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    final errorMessage =
        await AdminApi.authenticate(username.toLowerCase(), password);

    if (errorMessage == null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      usernameController.text = '';
      passwordController.text = '';
      Fluttertoast.showToast(
        msg: 'Failed to Authenticate',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color.fromARGB(255, 226, 30, 30),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.center,
                colors: [
                  Color.fromRGBO(97, 132, 223, 1),
                  Color.fromRGBO(47, 67, 120, 1),
                ],
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Admin Login Account",
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Please fill your detail to access your account.",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(251, 252, 255, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 27),
                  child: Image.asset('assets/images/User.png'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(46, 67, 120, 1),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Enter your Username",
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 5),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(46, 67, 120, 1),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Enter your Password",
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(28, 44, 85, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.9, 56),
                      ),
                      onPressed: () {
                        _login();
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
