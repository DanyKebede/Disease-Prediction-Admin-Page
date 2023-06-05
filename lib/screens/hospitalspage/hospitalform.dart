import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adminpage/provider/hospitalprovider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:provider/provider.dart';

import '../../models/hospital.dart';

class AddHospitalForm extends StatefulWidget {
  const AddHospitalForm({super.key});

  @override
  _AddHospitalFormState createState() => _AddHospitalFormState();
}

class _AddHospitalFormState extends State<AddHospitalForm> {
  // ignore: prefer_typing_uninitialized_variables
  var hospitalId;
  final _formKey = GlobalKey<FormState>();
  bool showImage = false;
  bool val = false;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final imgurlController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();
  final ratingController = TextEditingController();
  final emailController = TextEditingController();
  final hoursController = TextEditingController();

  final CloudinaryPublic _cloudinary =
      CloudinaryPublic('dcnhrexyh', 'q4hcsc8c', cache: false);

  Future<String> _uploadImage(String path) async {
    CloudinaryResponse response = await _cloudinary.uploadFile(
      CloudinaryFile.fromFile(path, resourceType: CloudinaryResourceType.Image),
    );
    return response.secureUrl;
  }

  Future<void> loadHospitalById() async {
    try {
      final HospitalModel HospitalDetail =
          await Provider.of<HospitalProvider>(context)
              .fetchHospitalById(hospitalId);
      nameController.text = HospitalDetail.name;
      phoneController.text = HospitalDetail.phone.toString();
      locationController.text = HospitalDetail.location;
      imgurlController.text = HospitalDetail.imgurl;
      latController.text = HospitalDetail.lat.toString();
      lngController.text = HospitalDetail.lng.toString();
      ratingController.text = HospitalDetail.rating.toString();
      emailController.text = HospitalDetail.email;
      hoursController.text = HospitalDetail.hours.toString();
      setState(() {
        imgurlController.text = HospitalDetail.imgurl;
      });
    } catch (e) {
      print('Error loading Hospitals: $e');
    }
  }

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    hospitalId = args?['HospitalId'];
    if (hospitalId != null) {
      loadHospitalById();

      val = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(46, 67, 120, 1),
          elevation: 0,
          centerTitle: true,
          title: Text(
            hospitalId != null ? "Edit Hospital" : "Add Hospital",
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Full Name",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter name',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nameController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Phone",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter phone number',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      phoneController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "location",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter location',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter location';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      locationController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Latitude",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: latController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter Latitude',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Latitude';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      latController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Longitude",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: lngController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter Longitude',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Longitude';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      latController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Rating",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: ratingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter rating',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter rating';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      ratingController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Email",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter email',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Hours",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: hoursController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter hours',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter hours';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      hoursController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  if (imgurlController.text != '')
                    Visibility(
                      visible: val,
                      child: !showImage
                          ? imgurlController.text != ''
                              ? Image.network(
                                  imgurlController.text,
                                  height: 100,
                                  width: 100,
                                )
                              : Image.asset(
                                  'assets/images/Hospital.png',
                                  width: 100,
                                  height: 100,
                                )
                          : Image.file(
                              File(imgurlController.text),
                              height: 100,
                              width: 100,
                            ),
                    ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 26, 61, 150),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(60, 56),
                    ),
                    child: const Text('Choose Image'),
                    onPressed: () async {
                      val = true;
                      final pickedFile = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          imgurlController.text = pickedFile.path;
                          showImage = true;
                        });
                      } else {
                        imgurlController.text = '';
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(28, 44, 85, 1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Inter'),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        val = false;
                        late String imageUrl = '';

                        try {
                          imageUrl = await _uploadImage(imgurlController.text)
                              .timeout(const Duration(seconds: 5));
                        } on TimeoutException catch (e) {
                          Fluttertoast.showToast(
                            msg: 'Image upload timed out',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          print('Upload image timed out after 3 seconds: $e');
                        } catch (e) {
                          print('Error uploading image: $e');
                        }
                        HospitalModel data = HospitalModel(
                          id: hospitalId,
                          name: nameController.text,
                          phone: phoneController.text,
                          location: locationController.text,
                          imgurl: hospitalId != null
                              ? showImage
                                  ? imageUrl
                                  : imgurlController.text
                              : imageUrl,
                          lat: double.parse(latController.text),
                          lng: double.parse(lngController.text),
                          email: emailController.text,
                          hours: int.parse(hoursController.text),
                          rating: double.parse(ratingController.text),
                        );
                        hospitalId != null
                            // ignore: use_build_context_synchronously
                            ? Provider.of<HospitalProvider>(context,
                                    listen: false)
                                .updateHospital(data)
                            // ignore: use_build_context_synchronously
                            : Provider.of<HospitalProvider>(context,
                                    listen: false)
                                .registerHospital(data);
                        Fluttertoast.showToast(
                          msg: hospitalId != null
                              ? 'Hospital Updated Successfully'
                              : 'Hospital Registered Successfully',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor:
                              const Color.fromARGB(255, 49, 233, 12),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );

                        Navigator.of(context).popUntil(
                            (route) => route.settings.name == '/home');
                        Navigator.of(context).pushNamed('/hospitalpage');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
