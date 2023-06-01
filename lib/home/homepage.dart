import 'package:flutter/material.dart';
import 'package:my_cube/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:my_cube/home/wrapper.dart';
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //for logout
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return  Scaffold(
      appBar: AppBar(
        title: Text("MY CUBE"),
        actions: [
          IconButton(
            onPressed: () {
              ap.userSignOut().then(
                    (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Wrapper(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[CircleAvatar(
            backgroundColor: Colors.purple,
            backgroundImage: NetworkImage(ap.userModel.profilepic),
            radius: 50,
          ),
            const SizedBox(height: 20),
            Text(ap.userModel.username),
            Text(ap.userModel.phoneNumber),
            Text(ap.userModel.email),
            Text(ap.userModel.bio),
            ElevatedButton(
              onPressed:() async{
                ap.userSignOut();
              },
              child: const Text('logout')
          ),
        ]),
      ),
    );
  }
}
