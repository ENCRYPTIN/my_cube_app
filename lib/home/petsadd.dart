import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cube/Models/petsusermodel.dart';
import 'package:my_cube/services/firestore_helper.dart';

class PetsAdd extends StatefulWidget {
  const PetsAdd({super.key});

  @override
  State<PetsAdd> createState() => _PetsAddState();
}
final CollectionReference petsCollection = FirebaseFirestore.instance.collection('family');



class _PetsAddState extends State<PetsAdd> {
  TextEditingController _petsnameController=TextEditingController();
  TextEditingController _DOBController=TextEditingController();
  TextEditingController _HeightController=TextEditingController();
  TextEditingController _WeightController=TextEditingController();
  TextEditingController _DescriptionController=TextEditingController();
  TextEditingController _LicencenumberController=TextEditingController();
  TextEditingController _SexController=TextEditingController();
  TextEditingController _MedicalController=TextEditingController();

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
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var firestorehelper=FirestoreHelper();
    return Scaffold(
      body: SafeArea(

        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.lightBlue,Colors.lightBlueAccent,Colors.indigoAccent],
                  begin: Alignment.topLeft,end: Alignment.bottomRight,stops: [0.1, 0.4, 0.6,]
              ),
            ),
            margin: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),

                TextFormField(
                  controller: _petsnameController,
                  decoration: InputDecoration(
                      fillColor:Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Pet Name",
                      hintText: 'Enter your name',
                      labelStyle:TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      )
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
                  controller: _HeightController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "HEIGHT",
                    hintText: "height in ft or inch",
                  ),
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: _WeightController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "WEIGHT",
                    hintText: "weight in kg",
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
                    hintText: "about your pet",
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                  ),
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: _LicencenumberController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "LICENCE NUMBER",
                    hintText: "Licence Number of your Pet",
                  ),
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: _SexController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "SEX",
                    hintText: "Male OR Female",
                  ),
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: _MedicalController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "MEDICAL HISTORY",
                    hintText: "Vet Details",
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                  ),
                ),

                Builder(
                    builder: (context) {
                      return ElevatedButton(
                        onPressed: () async {
                          firestorehelper.createpet(PetsUserModel(
                            Petsname: _petsnameController.text,
                            DOB: _DOBController.text,
                            height: _HeightController.text,
                            weight: _WeightController.text,
                            description: _DescriptionController.text,
                            licencenumber: _LicencenumberController.text,
                            sex: _SexController.text,
                            medicalhistory: _MedicalController.text,
                          ));
                          // Handle button click event
                          // Add your logic or function call here
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Friend()));
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
    );
  }
// Future _create() async{
//   final petsCollection=FirebaseFirestore.instance.collection("pets");
//
//   final docRef=petsCollection.doc();
//
//   await docRef.set({
//     "pets name": _petsnameController.text,
//     "Date of birth": _DOBController.text,
//     "Height": _HeightController.text,
//     "Weight": _WeightController.text,
//     "Description": _DescriptionController.text,
//     "Licence Number": _LicencenumberController.text,
//     "Sex": _SexController.text,
//     "Medical History": _MedicalController.text
//
//   });
//
//
// }

}

