import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cube/Models/friendsusers.dart';
import 'package:my_cube/services/firestore_helper.dart';
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



  @override
  Widget build(BuildContext context) {
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
                    height: 150,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),

                  ), TextFormField(
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
                            FirestoreHelper.create(FriendsUserModel(
                              Friendsname: _friendsnameController.text,
                              DOB: _DOBController.text,
                              nickname: _nicknameController.text,
                              sex: _sexController.text,
                              description: _DescriptionController.text,
                              phonenumber: _phonenumberController.text,
                              achivements: _achivementsController.text,
                              habbits: _habbitsController.text,
                            ));
                            // Handle button click event
                            // Add your logic or function call here
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => Family()));
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

