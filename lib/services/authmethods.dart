// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:my_cube/Models/user_model.dart' as model;
// import 'package:my_cube/Models/user_model.dart';
// import 'package:my_cube/services/storage_methods.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthMethods {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   UserModel? _userModel;
//   UserModel get userModel => _userModel!;
//   String? _uid;
//   String get uid => _uid!;
//   // get user details
//   Future<model.UserModel> getUserDetails() async {
//     User currentUser = _auth.currentUser!;
//     DocumentSnapshot documentSnapshot =
//     await _firestore.collection('Users').doc(currentUser.uid).get();
//     if (documentSnapshot.exists) {
//       final data = documentSnapshot.data() as Map<String, dynamic>;
//       _userModel = UserModel(
//         name: data['name']as String? ??'',
//         email: data['email']as String? ??'',
//         dateOfBirth: data['dateOfBirth']as String? ?? '',
//         fcmtoken: data['fcmtoken']as String? ?? '',
//         uid: data['uid']as String? ??'',
//         profilepic: data['profilepic']as String? ??'',
//         phoneNumber: data['phoneNumber']as String? ??'',
//         bio: data['bio']as String,
//         followers: data['followers']as List,
//         following: data["following"]as List,
//       );
//
//       _uid = _userModel!.uid;
//
//     } else {
//       // Handle the case where the document does not exist
//       print("Document Does not exist");
//
//
//     }
//     return _userModel!;
//   }
//
//   // Signing Up User
//
//   Future<String> signUpUser({
//     required String email,
//     required String password,
//     required String name,
//     required String bio,
//     required Uint8List file,
//     required String phoneNumber,
//     required String dateOfBirth,
//     required String fcmtoken,
//   }) async {
//     String res = "Some error Occurred";
//     try {
//       if (email.isNotEmpty ||
//           password.isNotEmpty ||
//           name.isNotEmpty ||
//           bio.isNotEmpty ) {
//         // registering user in auth with email and password
//         UserCredential cred = await _auth.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         String _uid=cred.user!.uid;
//         String profilepic =
//         await StorageMethods().uploadImageToStorage('$_uid/ProfilePic', file, false);
//
//         model.UserModel user = model.UserModel(
//           name: name,
//           uid: cred.user!.uid,
//           profilepic: profilepic,
//           email: email,
//           phoneNumber: phoneNumber,
//           fcmtoken: fcmtoken,
//           dateOfBirth: dateOfBirth,
//           bio: bio,
//           followers: [],
//           following: [],
//         );
//
//         // adding user in our database
//         await _firestore
//             .collection("Users")
//             .doc(cred.user!.uid)
//             .collection("PersonalData")
//             .doc(cred.user!.uid)
//             .set(user.toMap());
//
//         res = "success";
//       } else {
//         res = "Please enter all the fields";
//       }
//     } catch (err) {
//       return err.toString();
//     }
//     return res;
//   }
//
//   // logging in user
//   Future<String> loginUser({
//     required String email,
//     required String password,
//   }) async {
//     String res = "Some error Occurred";
//     try {
//       if (email.isNotEmpty || password.isNotEmpty) {
//         // logging in user with email and password
//         await _auth.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         res = "success";
//       } else {
//         res = "Please enter all the fields";
//       }
//     } catch (err) {
//       return err.toString();
//     }
//     return res;
//   }
//
//   Future<void> signOut() async {
//     SharedPreferences s = await SharedPreferences.getInstance();
//     await _auth.signOut();
//     s.clear();
//   }
//   Future saveUserDataToSP() async {
//     SharedPreferences s = await SharedPreferences.getInstance();
//     await s.setString("user_model", jsonEncode(userModel.toMap()));
//   }
// }