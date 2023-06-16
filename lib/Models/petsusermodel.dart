import 'package:cloud_firestore/cloud_firestore.dart';

class PetsUserModel {

  final String? Petsname;
  final String? DOB;
  final String? height;
  final String? weight;
  final String? description;
  final String? licencenumber;
  final String? sex;
  final String? medicalhistory;

  PetsUserModel({this.Petsname, this.DOB, this.height, this.weight, this.description, this.licencenumber, this.sex, this.medicalhistory});

  factory PetsUserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PetsUserModel(
        Petsname: snapshot['Petsname'],
        DOB: snapshot['Date of Birth'],
        height: snapshot['height'],
        weight: snapshot['weight'],
        description: snapshot['Description'],
        licencenumber: snapshot['Licencenumber'],
        sex: snapshot['Sex'],
        medicalhistory: snapshot['Medicalhistory']
    );
  }


  Map<String, dynamic> toJson() => {
    "Petsname": Petsname,
    "Date of Birth": DOB,
    "Height": height,
    "weight": weight,
    "description": description,
    "Licencenumber": licencenumber,
    "Sex": sex,
    "Medicalhistory": medicalhistory
  };
}

