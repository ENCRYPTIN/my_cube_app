import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_cube/home/profilepage.dart';
import 'package:my_cube/services/firestore_helper.dart';
import 'package:my_cube/Models/socialusermodel.dart';
class SocialHome extends StatefulWidget {
  const SocialHome({super.key});

  @override
  State<SocialHome> createState() => _SocialHomeState();
}

class _SocialHomeState extends State<SocialHome> {

  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    var firestorehelper=FirestoreHelper();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.00,
        title: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                Icons.people,
                color: Colors.blue,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Meet other Users of My Cube",
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
      ),
      body: SafeArea(
        child:Column(
          children: [
            StreamBuilder<List<SocialUserModel>>(
                stream: firestorehelper.readPersonalData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("some error occured"),);
                  }
                  if (snapshot.hasData) {
                    final personalDataCollection=snapshot.data;
                    return Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child:ListView.builder(itemCount: personalDataCollection!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){

                              final singleUser = personalDataCollection[index];

                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                          image: NetworkImage("${singleUser.profilepic}")
                                      ),
                                    ),
                                  ),
                                  title: InkWell(
                                    onTap: () {
                                      print("${singleUser.uid}");
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileScreen(
                                                uid: "${singleUser
                                                    .uid}", //(snapshot.data! as dynamic).docs[index]['uid'],
                                              ),
                                        ),
                                      );
                                    },
                                    child: Text("${singleUser.name}",
                                    ),
                                  ),
                                  subtitle: Text("${singleUser.phoneNumber}"),
                                ),
                              );
                            }),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator(),);
                }
            )
        ]),
      ),
    );
  }
}
