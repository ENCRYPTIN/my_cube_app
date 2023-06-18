

import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsUserModel{

  final String? id;
  final String? Friendsname;
  final String? DOB;
  final String? nickname;
  final String? sex;
  final String? description;
  final String? phonenumber;
  final String? achivements;
  final String? habbits;
  final String? fcmtoken;

  FriendsUserModel({this.id
    ,this.Friendsname,
    this.DOB,
    this.nickname,
    this.sex,
    this.description,
    this.phonenumber,
    this.achivements,
    this.habbits,
    this.fcmtoken,
  });

  factory FriendsUserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return FriendsUserModel(
        Friendsname: snapshot['friendsname'],
        DOB: snapshot['Date of Birth'],
        nickname: snapshot['nick name'],
        sex: snapshot['sex'],
        description: snapshot['description'],
        achivements: snapshot['achivements'],
        habbits: snapshot['habbits'],
        phonenumber:  snapshot['phone number'],
        id: snapshot['id'],
        fcmtoken: snapshot['fcmtoken'],
    );
  }

  Map<String, dynamic> toJson() => {
    "friendsname": Friendsname,
    "Date of Birth": DOB,
    "nick name": nickname,
    "sex": sex,
    "description": description,
    "achivements": achivements,
    "habbits": habbits,
    "phone number": phonenumber,
    "id": id,
    "fcmtoken":fcmtoken,
  };

}

