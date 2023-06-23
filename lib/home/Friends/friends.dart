import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_cube/Models/friendsusers.dart';
import 'package:my_cube/home/Friends/friendsedit.dart';
import 'package:my_cube/services/firestore_helper.dart';
import 'package:my_cube/home/Friends/friendadd.dart';


class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final CollectionReference friendsCollection = FirebaseFirestore.instance.collection('friends');
    var firestorehelper=FirestoreHelper();
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
              stream: firestorehelper.read(),
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
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: ListView.builder(itemCount: friendsCollection!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){

                            final singleUser = friendsCollection[index];

                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                onLongPress: () {
                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      title: Text("DELETE"),
                                      content: Text("Are you sure you wnat to delete this?"),
                                      actions: [
                                        ElevatedButton(onPressed: () {
                                          firestorehelper.deletefriend(singleUser).then((value) {
                                            Navigator.pop(context);
                                          });
                                        }, child: Text("DELETE"))
                                      ],
                                    );
                                  });
                                },
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlue,
                                      shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${singleUser.friendprofilepic}")),
                                  ),
                                ),
                                title: Text("${singleUser.Friendsname}"),
                                subtitle: Text("${singleUser.DOB}"),
                                trailing: InkWell( onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => FriendEditPage(friend: FriendsUserModel(
                                      Friendsname: singleUser.Friendsname,
                                      DOB: singleUser.DOB,
                                      nickname: singleUser.nickname,
                                      sex: singleUser.sex,
                                      description: singleUser.description,
                                      achivements: singleUser.achivements,
                                      phonenumber: singleUser.phonenumber,
                                      habbits: singleUser.habbits,
                                      id: singleUser.id,
                                    fcmtoken: singleUser.fcmtoken,
                                    friendprofilepic: singleUser.friendprofilepic,
                                  )
                                  ) ));
                                }, child: Icon(Icons.edit), ),

                              ),
                            );
                          }),
                    ),
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

