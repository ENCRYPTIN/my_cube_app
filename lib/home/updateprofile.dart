import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_cube/Widgets/text_field_input.dart';
import 'package:my_cube/services/auth.dart';
import 'package:my_cube/services/utils.dart';
import 'package:provider/provider.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});
  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? selectedDate;
  Uint8List? _image;
  bool isLoading = false;
  var userData = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("PersonalData")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      userData = userSnap.data()!;
      _usernameController.text=userData['name'];
      _bioController.text=userData['bio'];
      _dobController.text=userData['dateOfBirth'];
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }
  void updateUser() async {
    final AuthProvider authService =
    Provider.of<AuthProvider>(context, listen: false);
    // set loading to true
    setState(() {
      isLoading = true;
    });
    String res = await authService.updateUser(
        name: _usernameController.text,
        bio: _bioController.text,
        dateOfBirth: _dobController.text,
        profilepic: userData['profilepic'],
        file: _image);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      // navigate to the home screen
      if (context.mounted) {
        authService
            .getUserDetails()
            .then((value) => authService.saveUserDataToSP())
            .then((value) => authService.saveUserDataToSP())
            .then(
              (value) => Navigator.pop(context)
        );
      }
    } else {
      setState(() {
        isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }
  //Validations
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    // Check if the name contains any special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Special characters are not allowed';
    }
    // Check if the name contains any numbers
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Numbers are not allowed';
    }
    return null;
  }
  String? validateText(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    // Check if the text contains any special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Special characters are not allowed in $fieldName';
    }
    // Check if the text contains any numbers
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Numbers are not allowed in $fieldName';
    }
    return null;
  }

@override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _dobController.dispose();
    _bioController.dispose();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(child: SingleChildScrollView(
       child: Center(
         child: Padding(
           padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
           child: Form(
             key: _formKey,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Stack(
                   children: [
                     _image != null
                         ? CircleAvatar(
                       radius: 64,
                       backgroundImage: MemoryImage(_image!),
                       backgroundColor: Colors.red,
                     )
                         : CircleAvatar(
                       radius: 64,
                       backgroundImage: NetworkImage(
                         userData['profilepic'] ?? '',),
                       backgroundColor: Colors.red,
                     ),
                     Positioned(
                       bottom: -10,
                       left: 80,
                       child: IconButton(
                         onPressed: selectImage,
                         icon: const Icon(Icons.add_a_photo,color: Colors.lightBlueAccent,),
                       ),
                     )
                   ],
                 ),
                 const SizedBox(
                   height: 24,
                 ),
                 TextFieldInput(
                   hintText: 'Enter your username',
                   textInputType: TextInputType.text,
                   textEditingController: _usernameController,
                   validator: validateName,
                 ),
                 const SizedBox(
                   height: 24,
                 ),
                 TextFieldInput(
                     hintText: 'Enter your bio',
                     textInputType: TextInputType.text,
                     textEditingController: _bioController,
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Please enter some text';
                       }
                     }),
                 const SizedBox(
                   height: 24,
                 ),
                 Container(
                     margin: const EdgeInsets.only(
                       left: 10,
                     ),
                     child: const Align(
                       alignment: Alignment.centerLeft,
                       child: Padding(
                         padding: EdgeInsets.only(left: 15),
                         child: Text(
                           'Select Date of Birth, using calender icon',
                           textAlign: TextAlign.left,
                           style: TextStyle(
                               fontWeight: FontWeight.w600,
                               letterSpacing: 1.1,
                               fontFamily: 'Inter'),
                         ),
                       ),
                     )),
                 Container(
                   width: 390,
                   height: 46,
                   padding: const EdgeInsets.only(left: 15),
                   margin: const EdgeInsets.only( top: 10),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     border: Border.all(
                       width: 1,
                       color: const Color(0xFFC2C2C2),
                     ),
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Expanded(
                         child: Text(
                           _dobController.text,
                           style: TextStyle(
                             color: Colors.black,fontWeight: FontWeight.w500
                           ),
                         ),
                         flex: 7,
                       ),
                       Expanded(
                           flex: 3,
                           child: IconButton(
                               onPressed: () {
                                 _selectDate(context);
                               },
                               icon: Icon(Icons.calendar_month_outlined))),
                     ],
                   ),
                 ),
                 SizedBox(
                   height: 15,
                 ),
                 InkWell(
                   onTap: () {
                       if (_formKey.currentState?.validate() ?? false) {
                           updateUser();
                       }
                   },
                   child: Container(
                     width: double.infinity,
                     alignment: Alignment.center,
                     padding: const EdgeInsets.symmetric(vertical: 12),
                     decoration: const ShapeDecoration(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.all(Radius.circular(4)),
                       ),
                       color: Colors.lightBlueAccent,
                     ),
                     child: !isLoading
                         ? const Text(
                       'Sign up',
                     )
                         : const CircularProgressIndicator(
                       color: Colors.indigoAccent,
                     ),
                   ),
                 ),
               ],
             ),
           ),
         ),
       ),
     )),
    );
  }
}
