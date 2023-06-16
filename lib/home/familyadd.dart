import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cube/Models/familyusers.dart';
import 'package:my_cube/services/firestore_helper.dart';

class FamilyAdd extends StatefulWidget {
  const FamilyAdd({super.key});

  @override
  State<FamilyAdd> createState() => _FamilyAddState();
}
final CollectionReference familyCollection = FirebaseFirestore.instance.collection('family');



class _FamilyAddState extends State<FamilyAdd> {

  TextEditingController _familynameController = TextEditingController();
  TextEditingController _DOBController = TextEditingController();
  TextEditingController _realtionshipController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _habbitsController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _achivementsController = TextEditingController();

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
                    height: 150,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),

                  TextFormField(
                    controller: _DOBController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "DATE OF BIRTH",
                      hintText: "DOB",
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
                            FirestoreHelper.createfam(FamilyUserModel(
                              Familyname: _familynameController.text,
                              DOB: _DOBController.text,
                              age: _ageController.text,
                              relationship: _realtionshipController.text,
                              description: _descriptionController.text,
                              phonenumber: _phonenumberController.text,
                              achivements: _achivementsController.text,
                              habbits: _habbitsController.text,


                            ));

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
