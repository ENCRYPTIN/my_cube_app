import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_cube/Models/user_model.dart';
import 'package:my_cube/screens/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_cube/services/utils.dart';
import 'package:toast/toast.dart';

class AuthProvider extends ChangeNotifier{
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
//check if use is signed in
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  String currentuserkey='currentuserkey';

  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  //set loading while verifying otp
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _uid;
  String get uid => _uid!;

  AuthProvider(){
    checkSignIn();
  }

  checkSignIn() async{
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }
  // signin
  void signInWithPhone(BuildContext context, String phoneNumber,) async {
    ToastContext().init(context);
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
                await _auth.signInWithPhoneNumber(phoneNumber,);
                Toast.show("Verification Completed", duration: Toast.lengthShort, gravity:  Toast.bottom);
      },
          verificationFailed: (FirebaseAuthException error) {
            Toast.show('$error', duration: Toast.lengthShort, gravity:  Toast.bottom);
            throw FirebaseAuthException(code: error.code, message: error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Toast.show("Code Sent", duration: Toast.lengthShort, gravity:  Toast.bottom);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Otp(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      Toast.show('$e', duration: Toast.lengthShort, gravity:  Toast.bottom);
      print(e.message);
    }
  }

  //verifyotp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    ToastContext().init(context);
    Toast.show("Verifying OTP", duration: Toast.lengthShort, gravity:  Toast.bottom);
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _auth.signInWithCredential(creds)).user;
      if (user != null) {
        // carry our logic
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }
//DATABASE OPERATIONS

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
    await _firebaseFirestore.collection("Users/$_uid/PersonalData").doc(_uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  //saving data to cloud
  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
}) async{
    _isLoading=true;
    notifyListeners();
    try{
      // uploading image to firebase storage.
      await storeFileToStorage("$_uid/ProfilePic", profilePic).then((value) {
        userModel.uid = _auth.currentUser!.phoneNumber!;
        userModel.profilepic = value;
        userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        userModel.phoneNumber = _auth.currentUser!.phoneNumber!;
      });
      _userModel = userModel;

      // uploading to database
      await _firebaseFirestore
          .collection("Users/$_uid/PersonalData")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.toString());
      _isLoading = false;
      notifyListeners();
    }

  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getDataFromFirestore() async {
    String userid=_auth.currentUser!.uid;
    try {
      final DocumentSnapshot snapshot = await _firebaseFirestore
          .collection("Users")
          .doc(userid)
          .collection("PersonalData")
          .doc(userid)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        _userModel = UserModel(
          username: data['name']as String? ??'',
          email: data['email']as String? ??'',
          createdAt: data['createdAt']as String? ??'',
          dateOfBirth: data['dateOfBirth']as String? ?? '',
          fcmtoken: data['fcmtoken']as String? ?? '',
          uid: data['uid']as String? ??'',
          profilepic: data['profilepic']as String? ??'',
          phoneNumber: data['phoneNumber']as String? ??'',
        );

        _uid = _userModel!.uid;

      } else {
        // Handle the case where the document does not exist
       print("Document Does not exist");


      }
    } catch (e){
      print("error: $e");
    }
  }



  //STORING DATA LOCALLY
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }
  //fetching data from shared preferences
  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  //signout
  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _auth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }
}