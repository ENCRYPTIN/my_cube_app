import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:my_cube/Models/familyusers.dart';
import 'package:my_cube/services/firestore_helper.dart';
import 'package:my_cube/services/utils.dart';

class FamilyAdd extends StatefulWidget {
  const FamilyAdd({super.key});

  @override
  State<FamilyAdd> createState() => _FamilyAddState();
}
final CollectionReference familyCollection = FirebaseFirestore.instance.collection('family');



class _FamilyAddState extends State<FamilyAdd> {
  var firestorehelper=FirestoreHelper();
  TextEditingController _familynameController = TextEditingController();
  TextEditingController _DOBController = TextEditingController();
  TextEditingController _realtionshipController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _habbitsController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _achivementsController = TextEditingController();
  DateTime? selectedDate;
  @override
  void dispose() {
    _familynameController.dispose();
    _DOBController.dispose();
    _realtionshipController.dispose();
    _ageController.dispose();
    _descriptionController.dispose();
    _habbitsController.dispose();
    _phonenumberController.dispose();
    _achivementsController.dispose();
    // TODO: implement dispose
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
  String? fcmtoken="";
  void getToken() async{
    await FirebaseMessaging.instance.getToken().then(
            (token){
          setState(() {
            fcmtoken=token;
          });
        }
    );
  }
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),

                  TextFormField(
                    controller: _familynameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "NAME",
                      hintText: 'Name of the Member',
                    ),
                  ),

                  SizedBox(height: 16),
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child:  Container(
                      //padding: const EdgeInsets.only(top: 20.0),
                      child: InkWell(
                        onTap: () => selectImage(),//selectImage(),
                        child: image == null
                            ? const CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 60,
                          child: Icon(
                            Icons.account_circle,
                            size: 50,
                            color: Colors.white,
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
                  SizedBox(height: 16),

                  Container(
                      margin: const EdgeInsets.only(left: 10,top: 30),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('Select Date of Birth, using calender icon',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.1,
                                fontFamily: 'Inter'
                            ),
                          ),
                        ),
                      )
                  ),
                  Container(
                    width: 390,
                    height: 56,
                    padding: const EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(left: 10,right: 10, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xFFC2C2C2),
                      ),
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(_DOBController.text,),
                          flex: 7,
                        ),
                        Expanded(
                            flex: 3,
                            child: IconButton(onPressed: (){_selectDate(context);}, icon: Icon(Icons.calendar_month_outlined))),

                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _realtionshipController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "RELATIONSHIP",
                      hintText: "Relationship like father,mother,etc",
                    ),
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "AGE",
                      hintText: "Age of the Member",
                    ),
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _phonenumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "PHONE NUMBER",
                      hintText: "Phone Number",
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    controller: _achivementsController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "ACHIVEMENTS",
                      hintText: "Goals Achived",
                    ),
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "BRIEF DESCRIPTION",
                      hintText: "About your Friend",
                    ),
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    controller: _habbitsController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "HABBITS",
                      hintText: "Good Habbits",
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ),

                  Builder(
                      builder: (context) {
                        return ElevatedButton(
                          onPressed: () async {
                            if(image!=null) {
                              firestorehelper.createfam(FamilyUserModel(
                                Familyname: _familynameController.text,
                                DOB: _DOBController.text,
                                age: _ageController.text,
                                relationship: _realtionshipController.text,
                                description: _descriptionController.text,
                                phonenumber: _phonenumberController.text,
                                achivements: _achivementsController.text,
                                habbits: _habbitsController.text,
                                fcmtoken: fcmtoken,
                              ),image!).then((value) => Navigator.pop(context));
                            } else{
                              showSnackBar(context, "Please upload Pet photo");
                            }
                            // Handle button click event
                            // Add your logic or function call here
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                          },
                          child: Text('SAVE'),
                        );
                      }
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
