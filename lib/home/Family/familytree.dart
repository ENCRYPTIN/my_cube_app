import 'package:flutter/material.dart';
import 'package:my_cube/Models/familyusers.dart';
import 'package:my_cube/services/firestore_helper.dart';

class FamilyTree extends StatefulWidget {
  const FamilyTree({super.key});

  @override
  State<FamilyTree> createState() => _FamilyTreeState();
}

class _FamilyTreeState extends State<FamilyTree> {
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
          StreamBuilder<List<FamilyUserModel>>(
              stream: firestorehelper.readFather(),
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
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: ListView.builder(
                        itemCount: familyCollection!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final singleUser = familyCollection[index];

                          return Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        Text("Father"),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.lightBlue,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "${singleUser.familyprofilepic}")),
                                          ),
                                        ),
                                        Text("${singleUser.Familyname}")
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                        }),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
          StreamBuilder<List<FamilyUserModel>>(
              stream: firestorehelper.readMother(),
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
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: ListView.builder(
                        itemCount: familyCollection!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final singleUser = familyCollection[index];

                          return Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        Text("Mother"),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.lightBlue,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "${singleUser.familyprofilepic}")),
                                          ),
                                        ),
                                        Text("${singleUser.Familyname}")
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                        }),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ]),
      ),
    );
  }
}
