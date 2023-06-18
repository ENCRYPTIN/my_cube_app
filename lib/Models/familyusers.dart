import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyUserModel{
  final String? id;
  final String? Familyname;
  final String? DOB;
  final String? relationship;
  final String? age;
  final String? description;
  final String? habbits;
  final String? phonenumber;
  final String? achivements;
  final String? fcmtoken;

  FamilyUserModel({
    this.id,
    this.Familyname,
    this.DOB,
    this.relationship,
    this.age,
    this.description,
    this.habbits,
    this.phonenumber,
    this.achivements,
    this.fcmtoken,
  });

  factory FamilyUserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return FamilyUserModel(
        Familyname: snapshot['Familyname'],
        DOB: snapshot['Date of Birth'],
        relationship: snapshot['Relationship'],
        age: snapshot['age'],
        description: snapshot['description'],
        phonenumber: snapshot['Phonenumber'],
        habbits: snapshot['habbits'],
        achivements: snapshot['achivements'],
        id: snapshot['id'],
        fcmtoken: snapshot['fcmtoken'],
    );
  }

  Map<String, dynamic> toJson() => {
    "Familyname": Familyname,
    "Date of Birth": DOB,
    "Relationship": relationship,
    "age": age,
    "description": description,
    "achivements": achivements,
    "habbits": habbits,
    "Phonenumber": phonenumber,
    "id": id,
    "fcmtoken":fcmtoken,
  };
}

