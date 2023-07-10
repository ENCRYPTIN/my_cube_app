import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:my_cube/Models/petsusermodel.dart';
import 'package:my_cube/services/firestore_helper.dart';
import 'dart:io';

import '../../services/utils.dart';

class PetsAdd extends StatefulWidget {
  const PetsAdd({super.key});

  @override
  State<PetsAdd> createState() => _PetsAddState();
}

final CollectionReference petsCollection =
    FirebaseFirestore.instance.collection('family');

class _PetsAddState extends State<PetsAdd> {
  TextEditingController _petsnameController = TextEditingController();
  TextEditingController _DOBController = TextEditingController();
  TextEditingController _HeightController = TextEditingController();
  TextEditingController _WeightController = TextEditingController();
  TextEditingController _DescriptionController = TextEditingController();
  TextEditingController _LicencenumberController = TextEditingController();
  TextEditingController _SexController = TextEditingController();
  TextEditingController _MedicalController = TextEditingController();
  bool isLoading = false;
  //DOB Calender
  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _DOBController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }

  @override
  void dispose() {
    _petsnameController.dispose();
    _DOBController.dispose();
    _HeightController.dispose();
    _WeightController.dispose();
    _DescriptionController.dispose();
    _LicencenumberController.dispose();
    _SexController.dispose();
    _MedicalController.dispose();
    super.dispose();
  }

  //Image Picker
  File? image;
  // for selecting image
  void selectImage() async {
    image = await getImage(context);
    setState(() {});
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  String? fcmtoken = "";
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        fcmtoken = token;
      });
    });
  }

  String? validatePetname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a pet name';
    }
    // Check if the name contains any numbers
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Numbers are not allowed';
    }
    // Check if the name contains any special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Special characters are not allowed';
    }
    // Check if the first letter is capitalized
    if (!RegExp(r'^[A-Z]').hasMatch(value)) {
      return 'First letter should be capitalized';
    }
    return null;
  }

  String? validateHNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    // Check if the value is a valid number
    if (int.tryParse(value) == null) {
      return 'Please enter a valid $fieldName';
    }
    return null;
  }

  String? validateWNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    if (RegExp(r'[!@#$%^&*(),?":{}|<>]').hasMatch(value)) {
      return 'Special characters are not allowed in achievements';
    }
    // Check if the value is a valid number
    if (int.tryParse(value) == null) {
      return 'Please enter a valid $fieldName';
    }
    return null;
  }

  String? validateLNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    // Check if the value is a valid number
    if (int.tryParse(value) == null) {
      return 'Please enter a valid $fieldName';
    }
    return null;
  }

  String? validatesex(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter sex';
    }

    if (value.toLowerCase() != 'male' && value.toLowerCase() != 'female') {
      return 'Please enter either "Male" or "Female"';
    }

    return null;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var firestorehelper = FirestoreHelper();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(color: Colors.black12),
              //margin: EdgeInsets.only(left: 10,right: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        height: 170,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            image: DecorationImage(
                              image: AssetImage("assets/images/cat.jpg"),
                              fit: BoxFit.fill,
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'GOOD MEMORIES ARE FOREVER',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Text(
                              'Store your memories with us',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'We will remember it for you',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 16.0, height: 0.1),
                      controller: _petsnameController,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            gapPadding: 6.0,
                          ),
                          labelText: "Pet Name",
                          hintText: 'Enter your name',
                          labelStyle: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          )),
                      validator: validatePetname,
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200,
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.black87,
                          width: 1.0,
                        ),
                      ),
                      child: Container(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () => selectImage(), //selectImage(),
                          child: image == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 40,
                                    child: Icon(
                                      Icons.account_circle,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 200,
                                  //margin: const EdgeInsets.only(top: 8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(image!),
                                      )),
                                ),
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 10, top: 30),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'Select Date of Birth, using calender icon',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.1,
                                  fontFamily: 'Inter'),
                            ),
                          ),
                        )),
                    Container(
                      width: 390,
                      height: 56,
                      padding: const EdgeInsets.only(left: 15),
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xFFC2C2C2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              _DOBController.text,
                            ),
                            flex: 7,
                          ),
                          Expanded(
                              flex: 3,
                              child: IconButton(
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                  icon: Icon(Icons.calendar_month_outlined))),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      style: TextStyle(fontSize: 16.0, height: 0.1),
                      controller: _HeightController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "HEIGHT",
                        hintText: "height in ft or inch",
                      ),
                      validator: (value) => validateHNumber(value, "HEIGHT"),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      style: TextStyle(fontSize: 16.0, height: 0.1),
                      controller: _WeightController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "WEIGHT",
                        hintText: "weight in kg",
                      ),
                      validator: (value) => validateWNumber(value, "WEIGHT"),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.0,
                      ),
                      controller: _DescriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "  BRIEF DESCRIPTION",
                        hintText: "about your pet",
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      style: TextStyle(fontSize: 16.0, height: 0.1),
                      controller: _LicencenumberController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "LICENCE NUMBER",
                        hintText: "Licence Number of your Pet",
                      ),
                      validator: (value) =>
                          validateLNumber(value, "LICENCE NUMBER"),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      style: TextStyle(fontSize: 16.0, height: 0.1),
                      controller: _SexController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "SEX",
                        hintText: "Male OR Female",
                      ),
                      validator: validatesex,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      style: TextStyle(fontSize: 16.0, height: 0.1),
                      controller: _MedicalController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "  MEDICAL HISTORY",
                        hintText: "Vet Details",
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                      ),
                    ),
                    Builder(builder: (context) {
                      return isLoading
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  if (image != null) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    firestorehelper
                                        .createpet(
                                            PetsUserModel(
                                              Petsname:
                                                  _petsnameController.text,
                                              DOB: _DOBController.text,
                                              height: _HeightController.text,
                                              weight: _WeightController.text,
                                              description:
                                                  _DescriptionController.text,
                                              licencenumber:
                                                  _LicencenumberController.text,
                                              sex: _SexController.text,
                                              medicalhistory:
                                                  _MedicalController.text,
                                              fcmtoken: fcmtoken,
                                            ),
                                            image!)
                                        .then((valve) {
                                      Navigator.pop(context);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                  } else {
                                    showSnackBar(
                                        context, "Please upload Pet photo");
                                  }
                                } else {
                                  showSnackBar(
                                      context, "Please Properly enter details");
                                }
                              },
                              child: Text('SAVE'),
                            );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
