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
