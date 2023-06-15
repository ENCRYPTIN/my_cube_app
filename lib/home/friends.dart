import 'package:flutter/material.dart';
import 'package:my_cube/home/friendadd.dart';
class Friends extends StatelessWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Friends"),
          centerTitle: true,
          actions: [IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const FriendAdd()));}, icon: const Icon(Icons.add))],
        ),
      
        );
  }
}
