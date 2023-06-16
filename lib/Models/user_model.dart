class UserModel{
  String uid;
  String username;
  String email;
  String profilepic;
  String createdAt;
  String phoneNumber;
  String fcmtoken;
  String dateOfBirth;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.profilepic,
    required this.createdAt,
    required this.phoneNumber,
    required this.fcmtoken,
    required this.dateOfBirth,
  });
   //from map: getting data from server
  factory UserModel.fromMap(Map<String,dynamic>map){
  return UserModel(
      uid: map['uid']??'',
      username: map['username']??'',
      email: map['email']??'',
      profilepic: map['profilepic']??'',
      createdAt: map['createdAt']??'',
      phoneNumber: map['phoneNumber']??'',
      fcmtoken: map['fcmtoken']??'',
      dateOfBirth: map['dateOfBirth']??'',
  );
  }

  //to map: Adding data to server
  Map<String, dynamic> toMap(){
    return{
      "name":username,
      "email":email,
      "uid":uid,
      "profilepic":profilepic,
      "phoneNumber":phoneNumber,
      "createdAt":createdAt,
      "fcmtoken":fcmtoken,
      "dateOfBirth":dateOfBirth,
    };
  }
}
