

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
  final String? friendprofilepic;

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
    this.friendprofilepic,
  });

  factory FriendsUserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return FriendsUserModel(
        Friendsname: snapshot['friendsname'],
        DOB: snapshot['dateOfBirth'],
        nickname: snapshot['nick name'],
        sex: snapshot['sex'],
        description: snapshot['description'],
        achivements: snapshot['achivements'],
        habbits: snapshot['habbits'],
        phonenumber:  snapshot['phone number'],
        id: snapshot['id'],
        fcmtoken: snapshot['fcmtoken'],
        friendprofilepic: snapshot['friendprofilepic']
    );
  }

  Map<String, dynamic> toJson() => {
    "friendsname": Friendsname,
    "dateOfBirth": DOB,
    "nick name": nickname,
    "sex": sex,
    "description": description,
    "achivements": achivements,
    "habbits": habbits,
    "phone number": phonenumber,
    "id": id,
    "fcmtoken":fcmtoken,
    "friendprofilepic":friendprofilepic,
  };

}

