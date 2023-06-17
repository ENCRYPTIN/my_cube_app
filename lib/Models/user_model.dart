class UserModel{
  String uid;
  String name;
  String email;
  String profilepic;
  String createdAt;
  String phoneNumber;
  String fcmtoken;
  String dateOfBirth;

  UserModel({
    required this.uid,
    required this.name,
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
      name: map['name']??'',
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
}
