import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../provider/adminprovider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _oldPassword;
  late String _newPassword;
  late String _confirmPassword;

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _changePassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final response = await AdminApi.changePassword(
        _oldPassword, _newPassword, _confirmPassword);

    if (response == null) {
      // Password changed successfully
      setState(() {
        _isLoading = false;
        _errorMessage = null;
      });
      Fluttertoast.showToast(
        msg: 'Passworc Changed Successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color.fromARGB(255, 49, 233, 12),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.of(context).pop();
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(46, 67, 120, 1),
          elevation: 1,
          centerTitle: true,
          title: const Text(
            "Change Password",
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: _isLoading ? _buildLoading() : _buildForm(),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(46, 67, 120, 1),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Old Password",
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: Color.fromRGBO(198, 185, 185, 1),
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Old password is required.';
                }
                return null;
              },
              onSaved: (value) {
                _oldPassword = value!;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(46, 67, 120, 1),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "New Password",
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: Color.fromRGBO(198, 185, 185, 1),
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'New password is required.';
                }
                if (value.length < 8) {
                  return 'New password must be at least 8 characters long.';
                }
                return null;
              },
              onSaved: (value) {
                _newPassword = value!;
              },
              onChanged: (value) {
                _newPassword = value;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(46, 67, 120, 1),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Confirm Password",
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: Color.fromRGBO(198, 185, 185, 1),
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Confirm password is required.';
                }
                if (value != _newPassword) {
                  return 'Confirm password does not match new password.';
                }
                return null;
              },
              onSaved: (value) {
                _confirmPassword = value!;
              },
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(28, 44, 85, 1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 56),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _changePassword();
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Inter'),
              ),
            ),
            if (_errorMessage != null) ...[
              SizedBox(height: 16.0),
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
