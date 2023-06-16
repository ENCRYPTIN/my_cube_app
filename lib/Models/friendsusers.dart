

import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsUserModel{

  final String? Friendsname;
  final String? DOB;
  final String? nickname;
  final String? sex;
  final String? description;
  final String? phonenumber;
  final String? achivements;
  final String? habbits;

  FriendsUserModel({this.Friendsname, this.DOB, this.nickname, this.sex, this.description, this.phonenumber, this.achivements, this.habbits});

  factory FriendsUserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return FriendsUserModel(
      Friendsname: snapshot['friendsname'],
      DOB: snapshot['Date of Birth'],
      nickname: snapshot['Nick name'],
      sex: snapshot['sex'],
      description: snapshot['Description'],
      achivements: snapshot['Achivements'],
      habbits: snapshot['Habbits'],
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

  };

}

