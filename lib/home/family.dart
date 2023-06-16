import 'package:flutter/material.dart';
import 'package:my_cube/Models/familyusers.dart';
import 'package:my_cube/services/firestore_helper.dart';
import 'package:my_cube/home/familyadd.dart';
class Family extends StatelessWidget {
  const Family({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firestorehelper=FirestoreHelper();
    return  Scaffold(
      appBar: AppBar(
        title: Text("Family"),
        centerTitle: true,
        actions: [IconButton(
            onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>FamilyAdd()));},
            icon: Icon(Icons.add))],
      ),

      body: Column(
        children: [
          StreamBuilder<List<FamilyUserModel>>(
              stream: firestorehelper.readop(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(),);
                }
                if (snapshot.hasError) {
                  return Center(child: Text("some error occured"),);
                }
                if (snapshot.hasData) {
                  final familyCollection=snapshot.data;
                  return Expanded(
                    child: ListView.builder(itemCount: familyCollection!.length, itemBuilder: (context, index){
                      final singleUser = familyCollection[index];

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
                          title: Text("${singleUser.Familyname}"),
                          subtitle: Text("${singleUser.age}"),
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

