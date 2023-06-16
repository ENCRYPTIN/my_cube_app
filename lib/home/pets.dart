import 'package:flutter/material.dart';
import 'package:my_cube/Models/petsusermodel.dart';
import 'package:my_cube/services/firestore_helper.dart';
import 'package:my_cube/home/petsadd.dart';
class Pets extends StatelessWidget {
  const Pets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Pets"),
        centerTitle: true,
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PetsAdd()));
        }, icon: Icon(Icons.add))],
      ),

      body: Column(
        children: [
          StreamBuilder<List<PetsUserModel>>(
              stream: FirestoreHelper.readpet(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(),);
                }
                if (snapshot.hasError) {
                  return Center(child: Text("some error occured"),);
                }
                if (snapshot.hasData) {
                  final petsCollection=snapshot.data;
                  return Expanded(
                    child: ListView.builder(itemCount: petsCollection!.length, itemBuilder: (context, index){
                      final singleUser = petsCollection[index];
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
                          title: Text("${singleUser.Petsname}"),
                          subtitle: Text("${singleUser.licencenumber}"),
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

