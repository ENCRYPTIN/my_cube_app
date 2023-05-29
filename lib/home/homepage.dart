import 'package:flutter/material.dart';
import 'package:my_cube/services/auth.dart';
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final AuthProvider _auth=AuthProvider();
  @override
  Widget build(BuildContext context) {
    //for logout

    return  Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed:() async{
              await _auth.signOut();
            },
            child: const Text('logout')
        ),
      ),
    );
  }
}
