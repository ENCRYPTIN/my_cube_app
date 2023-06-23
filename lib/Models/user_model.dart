class UserModel{
  String uid;
  String name;
  String email;
  String profilepic;
  String phoneNumber;
  String fcmtoken;
  String dateOfBirth;
  String bio;
  List followers;
  List following;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilepic,
    required this.phoneNumber,
    required this.fcmtoken,
    required this.dateOfBirth,
    required this.bio,
    required this.followers,
    required this.following,
  });
   //from map: getting data from server
  factory UserModel.fromMap(Map<String,dynamic>map){
  return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      profilepic: map['profilepic'],
      phoneNumber: map['phoneNumber'],
      fcmtoken: map['fcmtoken'],
      dateOfBirth: map['dateOfBirth'],
      bio:map['bio'],
      followers: map['followers'],
      following: map['following'],
  );
  }

  //to map: Adding data to server
  Map<String, dynamic> toMap(){
    return{
      "name":name,
      "email":email,
      "uid":uid,
      "profilepic":profilepic,
      "phoneNumber":phoneNumber,
      "fcmtoken":fcmtoken,
      "dateOfBirth":dateOfBirth,
      "bio":bio,
      "followers":followers,
      "following":following,
    };
  }
}
