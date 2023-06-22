import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}


Future<File?> getImage(BuildContext context) async {
  File? image;
  final ImagePicker picker = ImagePicker();
  try {
    final XFile? Image = await picker.pickImage(source: ImageSource.gallery);
    if (Image != null) {
      image = File(Image.path);
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }

  return image;
}

class UserInfoTile extends StatelessWidget {
  final String label, value;
  //final EdgeInsetsGeometry margin, padding;
  UserInfoTile({required this.label, required this.value,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 10,right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('$label', style: TextStyle(color: Colors.indigoAccent, fontSize: 12)),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            color: Colors.grey,
            child: Text('$value', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'inter')),
          )
        ],
      ),
    );
  }
}