import 'package:cloud_firestore/cloud_firestore.dart';
class SocialUserModel{
  final String? uid;
  final String? name;
  final String? email;
  final String? profilepic;
  final String? createdAt;
  final String? phoneNumber;
  final String? fcmtoken;
  final String? dateOfBirth;

  SocialUserModel({
    this.uid,
    this.name,
    this.email,
    this.profilepic,
    this.createdAt,
    this.phoneNumber,
    this.fcmtoken,
    this.dateOfBirth,
  });
  //from map: getting data from server
  factory SocialUserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return SocialUserModel(
      uid: snapshot['uid'],
      name: snapshot['name'],
      email: snapshot['email'],
      profilepic: snapshot['profilepic'],
      createdAt: snapshot['createdAt'],
      phoneNumber: snapshot['phoneNumber'],
      fcmtoken: snapshot['fcmtoken'],
      dateOfBirth: snapshot['dateOfBirth'],
    );
  }

  //to map: Adding data to server
  Map<String, dynamic> toJson()=>{
      "name":name,
      "email":email,
      "uid":uid,
      "profilepic":profilepic,
      "phoneNumber":phoneNumber,
      "createdAt":createdAt,
      "fcmtoken":fcmtoken,
      "dateOfBirth":dateOfBirth,

  };
}
