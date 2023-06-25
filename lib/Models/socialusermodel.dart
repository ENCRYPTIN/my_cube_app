import 'package:cloud_firestore/cloud_firestore.dart';

class SocialUserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? profilepic;
  final String? phoneNumber;
  final String? fcmtoken;
  final String? dateOfBirth;
  final String? bio;
  final List? followers;
  final List? following;

  SocialUserModel({
    this.uid,
    this.name,
    this.email,
    this.profilepic,
    this.phoneNumber,
    this.fcmtoken,
    this.dateOfBirth,
    this.bio,
    this.followers,
    this.following,
  });
  //from map: getting data from server
  factory SocialUserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return SocialUserModel(
      uid: snapshot['uid'],
      name: snapshot['name'],
      email: snapshot['email'],
      profilepic: snapshot['profilepic'],
      phoneNumber: snapshot['phoneNumber'],
      fcmtoken: snapshot['fcmtoken'],
      dateOfBirth: snapshot['dateOfBirth'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }

  //to map: Adding data to server
  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
        "profilepic": profilepic,
        "phoneNumber": phoneNumber,
        "fcmtoken": fcmtoken,
        "dateOfBirth": dateOfBirth,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
