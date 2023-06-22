import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:my_cube/Models/friendsusers.dart';

import 'package:my_cube/services/firestore_helper.dart';
import 'package:my_cube/services/utils.dart';

class FriendAdd extends StatefulWidget {
  const FriendAdd({super.key});

  @override
  State<FriendAdd> createState() => _FriendAddState();
}
final CollectionReference friendsCollection = FirebaseFirestore.instance.collection('friends');

class _FriendAddState extends State<FriendAdd> {
  TextEditingController _friendsnameController=TextEditingController();
  TextEditingController _DOBController=TextEditingController();
  TextEditingController _nicknameController=TextEditingController();
  TextEditingController _sexController=TextEditingController();
  TextEditingController _DescriptionController=TextEditingController();
  TextEditingController _phonenumberController=TextEditingController();
  TextEditingController _achivementsController=TextEditingController();
  TextEditingController _habbitsController=TextEditingController();

  DateTime? selectedDate;
  @override
  void dispose() {
    _friendsnameController.dispose();
    _DOBController.dispose();
    _nicknameController.dispose();
    _sexController.dispose();
    _DescriptionController.dispose();
    _phonenumberController.dispose();
    _achivementsController.dispose();
    _habbitsController.dispose();
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
  @override
  Widget build(BuildContext context) {
    var firestorehelper=FirestoreHelper();

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),

                  TextFormField(
                    controller: _friendsnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "NAME",
                      hintText: 'Your Friend Name',
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
                  // TextFormField(
                  //   controller: _DOBController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     labelText: "DATE OF BIRTH",
                  //     hintText: "DOB",
                  //   ),
                  // ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Nick Name",
                      hintText: "Pet/Nick Name",
                    ),
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    controller: _sexController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "SEX",
                      hintText: " Male/Female",
                    ),
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    controller: _DescriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "BRIEF DESCRIPTION",
                      hintText: "About your Friend",
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
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
                    ),
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    controller: _achivementsController,
                    maxLines: 3,
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
                          onPressed: () async{
                            if(image!=null) {
                              firestorehelper.create(FriendsUserModel(
                                Friendsname: _friendsnameController.text,
                                DOB: _DOBController.text,
                                nickname: _nicknameController.text,
                                sex: _sexController.text,
                                description: _DescriptionController.text,
                                phonenumber: _phonenumberController.text,
                                achivements: _achivementsController.text,
                                habbits: _habbitsController.text,
                                fcmtoken: fcmtoken,
                              ), image!).then((valve) {
                                Navigator.pop(context);
                              });
                            }else{
                              showSnackBar(context, "Please upload Pet photo");
                            }
                          },
                          child: Text('SAVE'),
                        );



                      }

                  ),
                ],
              ),
            ),
          )
      ),


    );
  }

// Future _create() async{
//   final friendsCollection = FirebaseFirestore.instance.collection("friends");
//
//   final docRef=friendsCollection.doc();
//
//   await docRef.set({
//     "friendsname": _friendsnameController.text,
//     "Date of birth": _DOBController.text,
//     "Nick name": _nicknameController.text,
//     "Sex": _sexController.text,
//     "Brief Description": _DescriptionController.text,
//     "Phone number": _phonenumberController.text,
//     "Achivements": _achivementsController.text,
//     "Habbits": _habbitsController.text
//   });

//}

}

