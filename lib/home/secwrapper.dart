import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_cube/services/auth.dart';

class SecWrapper extends StatefulWidget {
  const SecWrapper({Key? key}) : super(key: key);

  @override
  State<SecWrapper> createState() => _SecWrapperState();
}

class _SecWrapperState extends State<SecWrapper> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    Future<bool> checkSignIn(BuildContext context) async {
      await authProvider.getDataFromSP();
      if (authProvider.isSignedIn == true) {
        return true;
      } else {
        return false;
      }
    }

    //return checkSignIn(context)==true ? HomePage() : WelcomeScreen();

    return FutureBuilder(
        future: checkSignIn(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Navigate to the home/register screen based on the result
            bool isSignedIn = snapshot.data ?? false;
            if (isSignedIn) {
              // Navigate to the home screen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed('/homepage');
              });
            } else {
              // Navigate to the welcome screen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed('/new user');
              });
            }
            return Container();
          }
        });
  }
}
