import 'package:flutter/material.dart';
//import 'package:my_cube/Models/user_model.dart';
import 'package:my_cube/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_cube/services/auth.dart';
class Proflie extends StatelessWidget {
  const Proflie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
              //   CircleAvatar(
              //     backgroundColor: Colors.purple,
              //     backgroundImage: NetworkImage(ap.userModel.profilepic),
              //     radius: 50,
              //   ),
              //   const SizedBox(height: 20),
              //   Text(ap.userModel.name),
              //   Text(ap.userModel.phoneNumber),
              //   Text(ap.userModel.email),
              //   Text(ap.userModel.dateOfBirth),
              //   ElevatedButton(onPressed: (){
              //     ap.userSignOut().then(
              //           (value) => Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const WelcomeScreen(),
              //         ),
              //       ),
              //     );
              //   },
              //       child:const Text("Log Out") )
            Container(
              height: 250,
              child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color(0xff0043ba), Color(0xff006df1)]),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(ap.userModel.profilepic)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
          ),
            ),
                SizedBox(height: 10),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          ap.userModel.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        const SizedBox(height: 16),
                        Column(
                          // You can use crossAxisAlignment to align the texts to the left
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // You can use mainAxisAlignment to give some space between the texts
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // You can use children to add the text widgets
                          children: [
                            // You can use a Container widget to add some padding and background color to the text
                            Container(
                              // You can use padding to give some space around the text
                              padding: EdgeInsets.all(8),
                              // You can use decoration to add some background color and border radius to the container
                              decoration: BoxDecoration(
                                // You can use color to choose a subtle background color for the container
                                color: Colors.grey[200],
                                // You can use borderRadius to make the container rounded
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // You can use a Row widget to add an icon and a text in a horizontal line
                              child: Row(
                                // You can use children to add the icon and text widgets
                                children: [
                                  // You can use an Icon widget to display an icon that describes the text
                                  Icon(
                                    // You can use Icons.email to display an email icon
                                    Icons.email,
                                    // You can use color to choose a nice color for the icon
                                    color: Colors.blue,
                                  ),
                                  // You can use a SizedBox widget to give some space between the icon and the text
                                  SizedBox(width: 8),
                                  // You can use an Expanded widget to make the text fill the remaining space in the row
                                  Expanded(
                                    // You can use a Text widget to display the email
                                    child: Text(
                                      // You can use ap.userModel.email as the data
                                      ap.userModel.email,
                                      // You can use style to customize the appearance of the text
                                      style: TextStyle(
                                        // You can use color to choose a nice color for the text
                                        color: Colors.black,
                                        // You can use fontSize to adjust the size of the text
                                        fontSize: 18,
                                      ),
                                      // You can use overflow and softWrap to handle long texts gracefully
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.cake,
                                    color: Colors.pink,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      ap.userModel.dateOfBirth,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      ap.userModel.phoneNumber,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                              onPressed: () {},
                              heroTag: 'Update',
                              elevation: 0,
                              label: Text("Update"),
                              icon: const Icon(Icons.person_add_alt_1),
                            ),
                            const SizedBox(width: 16.0),
                            FloatingActionButton.extended(
                              onPressed: () {
                                    ap.userSignOut().then(
                                          (value) => Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(builder: (context) => WelcomeScreen()),
                                                  (Route<dynamic> route) => false
                                          )
                                    );
                              },
                              heroTag: 'Logout',
                              elevation: 0,
                              backgroundColor: Colors.red,
                              label: Text("Log Out"),
                              icon: const Icon(Icons.logout_sharp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
               ]),
        ),
      ),
    );

  }
}
