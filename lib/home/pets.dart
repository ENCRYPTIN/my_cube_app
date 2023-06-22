import 'package:flutter/material.dart';
import 'package:my_cube/Models/petsusermodel.dart';
import 'package:my_cube/home/editpets.dart';
import 'package:my_cube/services/firestore_helper.dart';
import 'package:my_cube/home/petsadd.dart';
import 'package:flutter/foundation.dart';
class Pets extends StatefulWidget {
  const Pets({Key? key}) : super(key: key);

  @override
  State<Pets> createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var firestorehelper=FirestoreHelper();
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
              stream: firestorehelper.readpet(),
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
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: ListView.builder(itemCount: petsCollection!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            final singleUser = petsCollection[index];
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
                                          firestorehelper.deletepet(singleUser).then((value) {
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
                                        image: NetworkImage("${singleUser.petprofilepic}")),
                                  ),

                                ),
                                title: Text("${singleUser.Petsname}"),
                                subtitle: Text("${singleUser.licencenumber}"),
                                trailing: InkWell(onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditPets(pet: PetsUserModel(
                                      Petsname: singleUser.Petsname,
                                      DOB: singleUser.DOB,
                                      licencenumber: singleUser.licencenumber,
                                      medicalhistory: singleUser.medicalhistory,
                                      description: singleUser.description,
                                      sex: singleUser.sex,
                                      height: singleUser.height,
                                      weight: singleUser.weight,
                                      id: singleUser.id,
                                      fcmtoken: singleUser.fcmtoken,
                                      petprofilepic: singleUser.petprofilepic,
                                  ))));
                                }, child: Icon(Icons.edit),
                                ),
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

