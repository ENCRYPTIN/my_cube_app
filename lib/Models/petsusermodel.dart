import 'package:cloud_firestore/cloud_firestore.dart';

class PetsUserModel {
  final String? id;
  final String? Petsname;
  final String? DOB;
  final String? height;
  final String? weight;
  final String? description;
  final String? licencenumber;
  final String? sex;
  final String? medicalhistory;
  final String? fcmtoken;

  PetsUserModel({
    this.id,
    this.Petsname,
    this.DOB,
    this.height,
    this.weight,
    this.description,
    this.licencenumber,
    this.sex,
    this.medicalhistory,
    this.fcmtoken
  });

  factory PetsUserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PetsUserModel(
        Petsname: snapshot['Petsname'],
        DOB: snapshot['Date of Birth'],
        height: snapshot['Height'],
        weight: snapshot['weight'],
        description: snapshot['Description'],
        licencenumber: snapshot['Licencenumber'],
        sex: snapshot['Sex'],
        medicalhistory: snapshot['Medicalhistory'],
        id: snapshot['id'],
        fcmtoken: snapshot['fcmtoken'],
    );
  }


  Map<String, dynamic> toJson() => {
    "Petsname": Petsname,
    "Date of Birth": DOB,
    "Height": height,
    "weight": weight,
    "Description": description,
    "Licencenumber": licencenumber,
    "Sex": sex,
    "Medicalhistory": medicalhistory,
    "id":id,
    "fcmtoken":fcmtoken,
  };
}

