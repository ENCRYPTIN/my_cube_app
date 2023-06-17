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
      appBar: AppBar(

        backgroundColor: Colors.black12,
        elevation: 0.0,

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
            ),
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Container(
                  transformAlignment: Alignment.center,
                  padding: EdgeInsets.symmetric(),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('GOOD MEMORIES ARE FOREVER',
                      style: TextStyle(
                        fontSize: 16
                      ),),
                    Text('Store your memories with us'),
                    Text('We will remember it for you'),
                  ],
                ),),

                TextFormField(
                  style: TextStyle(fontSize: 16.0, height: 0.1),
                  controller: _petsnameController,
                  decoration: InputDecoration(
                      fillColor:Colors.black12,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        gapPadding: 6.0,
                      ),
                      labelText: "Pet Name",
                      hintText: 'Enter your name',
                      labelStyle:TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),

                SizedBox(height: 10),
                Container(
                  height: 200,
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
                  style: TextStyle(fontSize: 16.0, height: 0.1),
                  decoration: InputDecoration(
                    fillColor:Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "DATE OF BIRTH",
                    hintText: "DOB",
                  ),
                ),

                SizedBox(height: 16),

                TextFormField(
                  style: TextStyle(fontSize: 16.0, height: 0.1),
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
                  style: TextStyle(fontSize: 16.0, height: 0.1),
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
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.0,
                      height: 1.0,
                  ),
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
                  style: TextStyle(fontSize: 16.0, height: 0.1),
                  controller: _LicencenumberController,
                  maxLines: 1,
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
                  style: TextStyle(fontSize: 16.0, height: 0.1),
                  controller: _SexController,
                  maxLines: 1,
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
                  style: TextStyle(fontSize: 16.0, height: 0.1),
                  controller: _MedicalController,
                  maxLines: 1,
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

