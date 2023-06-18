import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_cube/screens/Onboarding.dart';
import 'package:provider/provider.dart';
import 'package:my_cube/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThreeWrapper extends StatefulWidget {
  const ThreeWrapper({Key? key}) : super(key: key);

  @override
  State<ThreeWrapper> createState() => _ThreeWrapperState();
}

class _ThreeWrapperState extends State<ThreeWrapper> {

  updatefcmtoken()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String? fcmtoken = await FirebaseMessaging.instance.getToken();
    String _uid = _auth.currentUser!.uid;
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    // Get the token from SharedPreferences with a key of 'fcmtoken'
    //tring? spfcmToken = prefs.getString('spfcmtoken');
    //print(spfcmToken);
    DocumentReference personalDataRef =
    FirebaseFirestore.instance.collection('Users').doc(_uid).collection('PersonalData').doc(_uid);
    personalDataRef.update({'fcmtoken': fcmtoken});

    //now for pets
    final petsCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Pets");
    // Get all documents in the petsCollection
    QuerySnapshot petsSnapshot = await petsCollection.get();
    // Check if the collection exists
    if (petsSnapshot.size > 0) {
      // Loop through the documents
      petsSnapshot.docs.forEach((petDoc) {
        // Create a reference to the pet document
        DocumentReference petRef = petDoc.reference;
        // Update the fcmtoken field in the document
        petRef.update({'fcmtoken': fcmtoken});
      });
    }
    //for family
    final familyCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Family");
    // Get all documents in the Collection
    QuerySnapshot familySnapshot = await familyCollection.get();
    // Check if the collection exists
    if (petsSnapshot.size > 0) {
      // Loop through the documents
      familySnapshot.docs.forEach((familyDoc) {
        // Create a reference to the pet document
        DocumentReference familyRef = familyDoc.reference;
        // Update the fcmtoken field in the document
        familyRef.update({'fcmtoken': fcmtoken});
      });
    }
    //for friend
    final friendsCollection = FirebaseFirestore.instance.collection(
        "Users/$_uid/Friends");
    // Get all documents in the petsCollection
    QuerySnapshot friendSnapshot = await friendsCollection.get();
    // Check if the collection exists
    if (petsSnapshot.size > 0) {
      // Loop through the documents
      friendSnapshot.docs.forEach((friendDoc) {
        // Create a reference to the pet document
        DocumentReference friendRef = friendDoc.reference;
        // Update the fcmtoken field in the document
        friendRef.update({'fcmtoken': fcmtoken});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Use a StreamBuilder widget instead of a FutureBuilder widget
    return StreamBuilder<User?>(
      // Use authStateChanges() method to get a stream of User objects
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Navigate to the home/register screen based on the result
            User? user = snapshot.data;
            if (user != null) {
              // Navigate to the home screen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                authProvider.getDataFromSP();
                updatefcmtoken();
                Navigator.of(context).pushReplacementNamed('/homepage');
              });
            } else {
              // Navigate to the welcome screen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                //Navigator.of(context).pushReplacementNamed('/new user');
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OnboardingPage(pages:
                [
                  OnboardingPageModel(
                  title: 'Stay connected with your loved ones',
                  description:
                  'Show them how much you care and appreciate them.',
                  image: 'assets/images/family.png',
                  bgColor: Colors.indigo,
                ),
                  OnboardingPageModel(
                    title: 'Keep in touch with best buddies.',
                    description: 'Share your memories and celebrate your friendship.',
                    image: 'assets/images/Friend.png',
                    bgColor: const Color(0xff1eb090),
                  ),
                  OnboardingPageModel(
                    title: 'Cherish your furry companions',
                    description:
                    'Spoil them with treats and toys on their special days.',
                    image: 'assets/images/pet.png',
                    bgColor: const Color(0xfff8bbd0),
                  ),
                ]
                )));
              });
            }
            return Container();
          }
        });
  }
}
