import 'package:flutter/material.dart';
import 'package:my_cube/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_cube/services/auth.dart';
import 'package:my_cube/home/wrapper.dart';
class Proflie extends StatelessWidget {
  const Proflie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body:Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              CircleAvatar(
                backgroundColor: Colors.purple,
                backgroundImage: NetworkImage(ap.userModel.profilepic),
                radius: 50,
              ),
              const SizedBox(height: 20),
              Text(ap.userModel.username),
              Text(ap.userModel.phoneNumber),
              Text(ap.userModel.email),
              Text(ap.userModel.bio),
              ElevatedButton(onPressed: (){
                ap.userSignOut().then(
                      (value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  ),
                );
              },
                  child:Text("Log Out") )
            ]),
      ),
    );

  }
}
