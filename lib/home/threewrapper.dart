import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_cube/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ThreeWrapper extends StatefulWidget {
  const ThreeWrapper({Key? key}) : super(key: key);

  @override
  State<ThreeWrapper> createState() => _ThreeWrapperState();
}

class _ThreeWrapperState extends State<ThreeWrapper> {
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
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed('/homepage');
                authProvider.getDataFromSP();
              });
            } else {
              // Navigate to the welcome screen
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed('/new user');
              });
            }
            return Container();
          }
        });
  }
}
