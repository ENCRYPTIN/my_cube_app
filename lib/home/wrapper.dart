//listen to authentication changes and
//display either home screen or welcome screen

import 'package:flutter/material.dart';
//import 'package:my_cube/Models/user.dart';
import 'package:my_cube/home/homepage.dart';
import 'package:my_cube/screens/welcome_screen.dart';
import 'package:my_cube/services/auth.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final user=Provider.of<AppUser?>(context);
    //variable of auth.dart
    final AuthProvider _authService=Provider.of<AuthProvider>(context, listen:false);
    //check if user signed in and return either home screen or welcomescreen
  return Scaffold(
    body: Center(
      child: ElevatedButton(
        onPressed: () async {
          if (_authService.isSignedIn == true) {
            await _authService.getDataFromSP().whenComplete(
                  () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
                  ),
              );

          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              ),
            );
          }
        },
        child: const Text("Check Sign IN"),
      ),
    ),
  );

  }
}
