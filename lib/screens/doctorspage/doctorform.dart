import 'dart:async';
import 'dart:io';

import 'package:adminpage/models/doctormodel.dart';
import 'package:adminpage/provider/doctorprovider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:provider/provider.dart';

import '../../provider/hospitalprovider.dart';

class AddDoctorForm extends StatefulWidget {
  const AddDoctorForm({super.key});

  @override
  AddDoctorFormState createState() => AddDoctorFormState();
}

class AddDoctorFormState extends State<AddDoctorForm> {
  Future<List<String>> getHospitalNames(String query) async {
    try {
      List<dynamic> data =
          Provider.of<HospitalProvider>(context, listen: false).hospitaldata;
      List d = data
          .where(
            (element) => element.name.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
      hospitalIdController.text = d.map((e) => e.id).toList()[0].toString();
      return d.map((e) => e.name.toString()).toList();
    } catch (e) {
      return const Iterable<String>.empty().toList();
    }
  }

  // ignore: prefer_typing_uninitialized_variables
  var doctorId;
  final _formKey = GlobalKey<FormState>();
  bool showImage = false;
  bool val = false;
  final ageController = TextEditingController();
  final hospitalIdController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final specialityController = TextEditingController();
  final imgurlController = TextEditingController();
  final titleController = TextEditingController();
  final experienceController = TextEditingController();
  final ratingController = TextEditingController();
  final emailController = TextEditingController();
  final hoursController = TextEditingController();
  final linkController = TextEditingController();

  final CloudinaryPublic _cloudinary =
      CloudinaryPublic('dcnhrexyh', 'q4hcsc8c', cache: false);

  Future<String> _uploadImage(String path) async {
    CloudinaryResponse response = await _cloudinary.uploadFile(
      CloudinaryFile.fromFile(path, resourceType: CloudinaryResourceType.Image),
    );
    return response.secureUrl;
  }

  Future<void> loadDoctorById() async {
    try {
      final DoctorModel doctorDetail =
          await Provider.of<DoctorProvider>(context).fetchDoctorById(doctorId);
      nameController.text = doctorDetail.name;
      ageController.text = doctorDetail.age.toString();
      phoneController.text = doctorDetail.phone.toString();
      specialityController.text = doctorDetail.speciality;
      imgurlController.text = doctorDetail.imgurl;
      titleController.text = doctorDetail.title;
      experienceController.text = doctorDetail.experiance.toString();
      ratingController.text = doctorDetail.rating.toString();
      emailController.text = doctorDetail.email;
      hoursController.text = doctorDetail.hours.toString();
      linkController.text = doctorDetail.link.toString();
      List<dynamic> data =
          // ignore: use_build_context_synchronously
          Provider.of<HospitalProvider>(context, listen: false).hospitaldata;
      List<dynamic> d = data.where((element) {
        return element.id == doctorDetail.hospital;
      }).toList();

      hospitalIdController.text = d.map((e) => e.name).toList()[0];
      setState(() {
        imgurlController.text = doctorDetail.imgurl;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error loading doctors: $e');
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    doctorId = args?['doctorId'];
    if (doctorId != null) {
      loadDoctorById();
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
            doctorId != null ? "Edit Doctor" : "Add Doctor",
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
                    "Age",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter age',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter age';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      ageController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Hospital",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return getHospitalNames(textEditingValue.text);
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      textEditingController.value = hospitalIdController.value;
                      return TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Enter hospital name',
                          hintStyle: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            color: Color.fromRGBO(198, 185, 185, 1),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter hospital name';
                          }
                          return null;
                        },
                        onFieldSubmitted: (String value) {
                          onFieldSubmitted();
                        },
                      );
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
                    "Speciality",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: specialityController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter speciality',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter speciality';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      specialityController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Title",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter title',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      titleController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Experiance",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: experienceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter years of experience',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter years of experience';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      experienceController.text = value!;
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
                  const Text(
                    "Link",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter', fontSize: 15),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: linkController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter link',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color.fromRGBO(198, 185, 185, 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter link';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      linkController.text = value!;
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
                                  'assets/images/doctor.png',
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
                          .pickImage(source: ImageSource.gallery);
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
                        } on TimeoutException catch (_) {
                          Fluttertoast.showToast(
                            msg: 'Image upload timed out',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } catch (e) {
                          if (kDebugMode) {
                            print('Error uploading image: $e');
                          }
                        }
                        DoctorModel data = DoctorModel(
                          id: doctorId,
                          age: int.parse(ageController.text),
                          hospital: int.parse(hospitalIdController.text),
                          name: nameController.text,
                          phone: phoneController.text,
                          speciality: specialityController.text,
                          imgurl: doctorId != null
                              ? showImage
                                  ? imageUrl
                                  : imgurlController.text
                              : imageUrl,
                          title: titleController.text,
                          email: emailController.text,
                          experiance: int.parse(experienceController.text),
                          hours: int.parse(hoursController.text),
                          rating: double.parse(ratingController.text),
                          link: linkController.text,
                        );

                        doctorId != null
                            // ignore: use_build_context_synchronously
                            ? Provider.of<DoctorProvider>(context,
                                    listen: false)
                                .updateDoctor(data)
                            // ignore: use_build_context_synchronously
                            : Provider.of<DoctorProvider>(context,
                                    listen: false)
                                .registerDoctor(data);
                        Fluttertoast.showToast(
                          msg: doctorId != null
                              ? 'Doctor Updated Successfully'
                              : 'Doctor Registered Successfully',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor:
                              const Color.fromARGB(255, 49, 233, 12),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).popUntil(
                            (route) => route.settings.name == '/home');
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushNamed('/doctorpage');
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
