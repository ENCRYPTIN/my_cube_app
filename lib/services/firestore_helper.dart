
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_cube/Models/familyusers.dart';
import 'package:my_cube/Models/friendsusers.dart';
import 'package:my_cube/Models/petsusermodel.dart';

import '../Models/socialusermodel.dart';



class FirestoreHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
//Friend
  Stream<List<FriendsUserModel>> read() {
    String _uid = _auth.currentUser!.uid;
    final friendsCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Friends");
    return friendsCollection.snapshots().map((querrySnapshot) =>
        querrySnapshot.docs.map((e) => FriendsUserModel.fromSnapshot(e))
            .toList());
  }


  Future create(FriendsUserModel friend) async {
    String _uid = _auth.currentUser!.uid;
    final friendsCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Friends");


    final docRef = friendsCollection.doc();
    final uid = docRef.id;
    final newFriend = FriendsUserModel(
      id: uid,
      Friendsname: friend.Friendsname,
      DOB: friend.DOB,
      nickname: friend.nickname,
      sex: friend.sex,
      description: friend.description,
      phonenumber: friend.phonenumber,
      achivements: friend.achivements,
      habbits: friend.habbits,
      fcmtoken: friend.fcmtoken,

    ).toJson();

    try {
      await docRef.set(newFriend);
    } catch (e) {
      print("some error occured $e");
    }
  }

  updatefriend(FriendsUserModel friend) async {
    String _uid = _auth.currentUser!.uid;

    final FriendsCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Friends/");

    final docRef = FriendsCollection.doc(friend.id);


    final newFriend = FriendsUserModel(
      id: friend.id,
      Friendsname: friend.Friendsname,
      DOB: friend.DOB,
      nickname: friend.nickname,
      sex: friend.sex,
      description: friend.description,
      phonenumber: friend.phonenumber,
      achivements: friend.achivements,
      habbits: friend.habbits,
      fcmtoken: friend.fcmtoken,

    ).toJson();

    try {
      await docRef.update(newFriend);
    } catch (e) {
      print("some error occured $e");
    }
  }
  deletefriend(FriendsUserModel friend) async {
    String _uid = _auth.currentUser!.uid;

    final FriendsCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Friends/");
    print(_uid);

    final docRef = FriendsCollection.doc(friend.id);
    docRef.delete();
  }

  //Family Section
  Stream<List<FamilyUserModel>> readop() {
    String _uid = _auth.currentUser!.uid;
    final familyCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Family");
    return familyCollection.snapshots().map((querrySnapshot) =>
        querrySnapshot.docs.map((e) => FamilyUserModel.fromSnapshot(e))
            .toList());
  }

  Future createfam(FamilyUserModel family) async {
    String _uid = _auth.currentUser!.uid;
    final familyCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Family");

    final docRef = familyCollection.doc();
    final uid = docRef.id;

    final newFamily = FamilyUserModel(
      id: uid,
      Familyname: family.Familyname,
      DOB: family.DOB,
      age: family.age,
      relationship: family.relationship,
      habbits: family.habbits,
      description: family.description,
      phonenumber: family.phonenumber,
      achivements: family.achivements,
        fcmtoken: family.fcmtoken
    ).toJson();

    try {
      await docRef.set(newFamily);
    } catch (e) {
      print("some error occured $e");
    }
  }

  Future updatefamily(FamilyUserModel family) async {
    String _uid = _auth.currentUser!.uid;
    final familyCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Family");

    final docRef = familyCollection.doc(family.id);

    final newFamily = FamilyUserModel(
        id: family.id,
        Familyname: family.Familyname,
        age: family.age,
        relationship: family.relationship,
        habbits: family.habbits,
        description: family.description,
        phonenumber: family.phonenumber,
        achivements: family.achivements,
        DOB: family.DOB,
        fcmtoken: family.fcmtoken,
    ).toJson();

    try {
      await docRef.update(newFamily);
    } catch (e) {
      print("some error occured $e");
    }
  }

  deletefamily(FamilyUserModel family) async {
    String _uid = _auth.currentUser!.uid;

    final familyCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Family");
    print(_uid);

    final docRef = familyCollection.doc(family.id);
    docRef.delete();
  }

//Pet Section
  Stream<List<PetsUserModel>> readpet() {
    String _uid = _auth.currentUser!.uid;
    final petsCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Pets");
    return petsCollection.snapshots().map((querrySnapshot) =>
        querrySnapshot.docs.map((e) => PetsUserModel.fromSnapshot(e)).toList());
  }

  createpet(PetsUserModel pet) async {
    String _uid = _auth.currentUser!.uid;
    final petsCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Pets");

    final docRef = petsCollection.doc();
    final uid = docRef.id;
    final newPet = PetsUserModel(
        id: uid,
        Petsname: pet.Petsname,
        DOB: pet.DOB,
        height: pet.height,
        weight: pet.weight,
        description: pet.description,
        licencenumber: pet.licencenumber,
        sex: pet.sex,
        medicalhistory: pet.medicalhistory,
        fcmtoken: pet.fcmtoken

    ).toJson();

    try {
      await docRef.set(newPet);
    } catch (e) {
      print("some error occured $e");
    }
  }

  updatepet(PetsUserModel pet) async {
    String _uid = _auth.currentUser!.uid;
    final petsCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Pets");

    final docRef = petsCollection.doc(pet.id);

    final newPet = PetsUserModel(
        id: pet.id,
        Petsname: pet.Petsname,
        DOB: pet.DOB,
        height: pet.height,
        weight: pet.weight,
        description: pet.description,
        licencenumber: pet.licencenumber,
        sex: pet.sex,
        medicalhistory: pet.medicalhistory,
        fcmtoken: pet.fcmtoken

    ).toJson();

    try {
      await docRef.update(newPet);
    } catch (e) {
      print("some error occured $e");
    }
  }


  deletepet(PetsUserModel pet) async {
    String _uid = _auth.currentUser!.uid;

    final petsCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Pets");
    print(_uid);

    final docRef = petsCollection.doc(pet.id);
    docRef.delete();
  }
//For Socailhome
//   Stream<List<SocialUserModel>> readPersonalData() {
//     var myUserId = _auth.currentUser!.uid;
    //Working code:
    // Query personalDataCollection = FirebaseFirestore.instance.collectionGroup(
    //     "PersonalData");
    //
    // return personalDataCollection.snapshots().map((querrySnapshot) =>
    //     querrySnapshot.docs.map((e) => SocialUserModel.fromSnapshot(e))
    //         .toList());

     //Experimental Code
    //var myUserId = _auth.currentUser!.uid;
    // Query otherData = FirebaseFirestore.collectionGroup('PersonalData').where('uid', '!=', myUserId,true);
    // Get the current user's uid
//For Socailhome
//For Socailhome
  Stream<List<SocialUserModel>> readPersonalData() {
    var myUserId = _auth.currentUser!.uid;
    // Query the collection group "PersonalData"
    var allData = FirebaseFirestore.instance.collectionGroup('PersonalData');

    // Get the data from the query as a stream
    return allData.snapshots().asyncMap((querySnapshot) async {
      // Create an empty list to store the SocialUserModel objects
      List<SocialUserModel> socialUserModels = [];
      // Loop through the documents
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Check if the document name is different from the current user's uid
        if (doc.id != myUserId) {
          // Create a SocialUserModel object from the document data
          SocialUserModel socialUserModel = SocialUserModel.fromSnapshot(doc);
          // Add the SocialUserModel object to the list
          socialUserModels.add(socialUserModel);
        }
      }
      // Return the list of SocialUserModel objects
      return socialUserModels;
    });
  }

}

