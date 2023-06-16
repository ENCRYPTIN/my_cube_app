
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cube/Models/familyusers.dart';
import 'package:my_cube/Models/friendsusers.dart';
import 'package:my_cube/Models/petsusermodel.dart';

class FirestoreHelper{

  static Stream<List<FriendsUserModel>> read()
  {
    final friendsCollection = FirebaseFirestore.instance.collection("friends");
    return friendsCollection.snapshots().map((querrySnapshot) => querrySnapshot.docs.map((e) => FriendsUserModel.fromSnapshot(e)).toList());

  }




  static Future create(FriendsUserModel friend) async {
    final friendsCollection = FirebaseFirestore.instance.collection("friends");

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

  static Stream<List<FamilyUserModel>> readop()
  {
    final familyCollection = FirebaseFirestore.instance.collection("family");
    return familyCollection.snapshots().map((querrySnapshot) => querrySnapshot.docs.map((e) => FamilyUserModel.fromSnapshot(e)).toList());

  }


  static Future createfam(FamilyUserModel family) async {
    final familyCollection = FirebaseFirestore.instance.collection("family");

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

  static Stream<List<PetsUserModel>> readpet()
  {
    final petsCollection = FirebaseFirestore.instance.collection("pets");
    return petsCollection.snapshots().map((querrySnapshot) => querrySnapshot.docs.map((e) => PetsUserModel.fromSnapshot(e)).toList());

  }

  static createpet(PetsUserModel pet) async{
    final petsCollection=FirebaseFirestore.instance.collection("pets");

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

