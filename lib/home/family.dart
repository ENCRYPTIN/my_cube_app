import 'package:flutter/material.dart';
import 'package:my_cube/home/familyadd.dart';
class Family extends StatelessWidget {
  const Family({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Family"),
        centerTitle: true,
        actions: [IconButton(
            onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>const FamilyAdd()));},
            icon: const Icon(Icons.add))],
      ),

    );
  }
}
