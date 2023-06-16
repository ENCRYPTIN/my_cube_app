import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_cube/Models/friendsusers.dart';
import 'package:my_cube/services/auth.dart';
import 'package:my_cube/services/firestore_helper.dart';
import 'package:my_cube/home/friendadd.dart';
import 'package:provider/provider.dart';
class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  @override
  Widget build(BuildContext context) {
    //final CollectionReference friendsCollection = FirebaseFirestore.instance.collection('friends');
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Friends"),
        centerTitle: true,
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>FriendAdd()));}, icon: Icon(Icons.add))],
      ),
      body: Column(
        children: [
          StreamBuilder<List<FriendsUserModel>>(
              stream: ap.read(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(),);
                }
                if (snapshot.hasError) {
                  return Center(child: Text("some error occured"),);
                }
                if (snapshot.hasData) {
                  final friendsCollection=snapshot.data;
                  return Expanded(
                    child: ListView.builder(itemCount: friendsCollection!.length, itemBuilder: (context, index){
                      final singleUser = friendsCollection[index];

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                shape: BoxShape.circle
                            ),
                          ),
                          title: Text("${singleUser.Friendsname}"),
                          subtitle: Text("${singleUser.DOB}"),
                        ),
                      );
                    }),
                  );
                }
                return Center(child: CircularProgressIndicator(),);

              }
          )
        ],

      ),

    );
  }
}

