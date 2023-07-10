import 'package:flutter/material.dart';
import 'package:my_cube/Models/familyusers.dart';
import 'package:my_cube/home/Family/editfamily.dart';
import 'package:my_cube/home/Family/familyprofile.dart';
import 'package:my_cube/home/Family/familytree.dart';
import 'package:my_cube/services/firestore_helper.dart';
import 'package:my_cube/home/Family/familyadd.dart';

class Family extends StatefulWidget {
  const Family({Key? key}) : super(key: key);

  @override
  State<Family> createState() => _FamilyState();
}

class _FamilyState extends State<Family> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var firestorehelper = FirestoreHelper();
    return Scaffold(
      appBar: AppBar(
        title: Text("Family"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FamilyTree()));
              },
              icon: Icon(Icons.forest_outlined)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FamilyAdd()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<List<FamilyUserModel>>(
              stream: firestorehelper.readop(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("some error occured"),
                  );
                }
                if (snapshot.hasData) {
                  final familyCollection = snapshot.data;
                  return Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: ListView.builder(
                          itemCount: familyCollection!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final singleUser = familyCollection[index];

                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FamilyProflie(
                                                  family: FamilyUserModel(
                                                Familyname:
                                                    singleUser.Familyname,
                                                DOB: singleUser.DOB,
                                                relationship:
                                                    singleUser.relationship,
                                                age: singleUser.age,
                                                habbits: singleUser.habbits,
                                                achivements:
                                                    singleUser.achivements,
                                                description:
                                                    singleUser.description,
                                                phonenumber:
                                                    singleUser.phonenumber,
                                                id: singleUser.id,
                                                fcmtoken: singleUser.fcmtoken,
                                                familyprofilepic:
                                                    singleUser.familyprofilepic,
                                              ))));
                                },
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("DELETE"),
                                          content: Text(
                                              "Are you sure you wnat to delete this?"),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  firestorehelper
                                                      .deletefamily(singleUser)
                                                      .then((value) {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text("DELETE"))
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
                                        image: NetworkImage(
                                            "${singleUser.familyprofilepic}")),
                                  ),
                                ),
                                title: Text(
                                  "${singleUser.Familyname}",
                                  textAlign: TextAlign.start,
                                ),
                                subtitle: Text("${singleUser.age}"),
                                trailing: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditFamily(
                                                    family: FamilyUserModel(
                                                  Familyname:
                                                      singleUser.Familyname,
                                                  DOB: singleUser.DOB,
                                                  relationship:
                                                      singleUser.relationship,
                                                  age: singleUser.age,
                                                  habbits: singleUser.habbits,
                                                  achivements:
                                                      singleUser.achivements,
                                                  description:
                                                      singleUser.description,
                                                  phonenumber:
                                                      singleUser.phonenumber,
                                                  id: singleUser.id,
                                                  fcmtoken: singleUser.fcmtoken,
                                                  familyprofilepic: singleUser
                                                      .familyprofilepic,
                                                ))));
                                  },
                                  child: Icon(Icons.edit),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })
        ],
      ),
    );
  }
}
