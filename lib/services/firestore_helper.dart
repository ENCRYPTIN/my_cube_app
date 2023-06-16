
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_cube/Models/familyusers.dart';
import 'package:my_cube/Models/friendsusers.dart';
import 'package:my_cube/Models/petsusermodel.dart';


class FirestoreHelper{
  final FirebaseAuth _auth= FirebaseAuth.instance;
   Stream<List<FriendsUserModel>> read()
   {
     String _uid=_auth.currentUser!.uid;
    final friendsCollection = FirebaseFirestore.instance.collection("Users/$_uid/Friends");
    return friendsCollection.snapshots().map((querrySnapshot) => querrySnapshot.docs.map((e) => FriendsUserModel.fromSnapshot(e)).toList());

  }


   Future create(FriendsUserModel friend) async {
     String _uid=_auth.currentUser!.uid;
     final friendsCollection = FirebaseFirestore.instance.collection("Users/$_uid/Friends");

    final docRef = friendsCollection.doc();

    final newFriend = FriendsUserModel(
      Friendsname: friend.Friendsname,
      DOB: friend.DOB,
      nickname: friend.nickname,
      sex: friend.sex,
      description: friend.description,
      phonenumber: friend.phonenumber,
      achivements: friend.achivements,
      habbits: friend.habbits,

    ).toJson();

    try{
      await docRef.set(newFriend);
    }catch(e){
      print("some error occured $e");
    }

  }

   Stream<List<FamilyUserModel>> readop()
  {
    String _uid=_auth.currentUser!.uid;
    final familyCollection = FirebaseFirestore.instance.collection("Users/$_uid/Family");
    return familyCollection.snapshots().map((querrySnapshot) => querrySnapshot.docs.map((e) => FamilyUserModel.fromSnapshot(e)).toList());

  }


   Future createfam(FamilyUserModel family) async {
    String _uid=_auth.currentUser!.uid;
    final familyCollection = FirebaseFirestore.instance.collection("Users/$_uid/Family");

    final docRef = familyCollection.doc();

    final newFamily= FamilyUserModel(
      Familyname: family.Familyname,
      age: family.age,
      relationship: family.relationship,
      habbits: family.habbits,
      description: family.description,
      phonenumber: family.phonenumber,
      achivements: family.achivements,
    ).toJson();

    try{
      await docRef.set(newFamily);
    }catch(e){
      print("some error occured $e");
    }

  }

  Stream<List<PetsUserModel>> readpet()
  {
    String _uid=_auth.currentUser!.uid;
    final petsCollection = FirebaseFirestore.instance.collection("Users/$_uid/Pets");
    return petsCollection.snapshots().map((querrySnapshot) => querrySnapshot.docs.map((e) => PetsUserModel.fromSnapshot(e)).toList());

  }

   createpet(PetsUserModel pet) async{
    String _uid=_auth.currentUser!.uid;
    final petsCollection=FirebaseFirestore.instance.collection("Users/$_uid/Pets");

    final docRef=petsCollection.doc();

    final newPet=PetsUserModel(
        Petsname: pet.Petsname,
        DOB: pet.DOB,
        height: pet.height,
        weight: pet.weight,
        description: pet.description,
        licencenumber: pet.licencenumber,
        sex: pet.sex,
        medicalhistory: pet.medicalhistory

    ).toJson();

    try{
      await docRef.set(newPet);
    }catch(e){
      print("some error occured $e");
    }


  }


}

