import 'package:flutter/material.dart';
import 'package:my_cube/home/petsadd.dart';
class Pets extends StatelessWidget {
  const Pets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Pets"),
          centerTitle: true,
          actions: [IconButton(onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const PetsAdd()));
          }, icon: const Icon(Icons.add))],
        ),

    );
  }
}
