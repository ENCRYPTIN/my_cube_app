class UserModel{
  String uid;
  String username;
  String email;
  String bio;
  String profilepic;
  String createdAt;
  String phoneNumber;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.bio,
    required this.profilepic,
    required this.createdAt,
    required this.phoneNumber
  });
   //from map: getting data from server
  factory UserModel.fromMap(Map<String,dynamic>map){
  return UserModel(
      uid: map['uid']??'',
      username: map['username']??'',
      email: map['email']??'',
      bio: map['bio']??'',
      profilepic: map['profilepic']??'',
      createdAt: map['createdAt']??'',
      phoneNumber: map['phoneNumber']??'');
  }

  //to map: Adding data to server
  Map<String, dynamic> toMap(){
    return{
      "name":username,
      "email":email,
      "uid":uid,
      "bio":bio,
      "profilepic":profilepic,
      "phoneNumber":phoneNumber,
      "createdAt":createdAt,
    };
  }
}
