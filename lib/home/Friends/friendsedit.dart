import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_cube/Models/friendsusers.dart';
import 'package:my_cube/services/firestore_helper.dart';
import 'package:my_cube/services/utils.dart';

class FriendEditPage extends StatefulWidget {
  final FriendsUserModel friend;
  const FriendEditPage({super.key, required this.friend});

  @override
  State<FriendEditPage> createState() => _FriendEditPageState();
}

var firestorehelper = FirestoreHelper();

class _FriendEditPageState extends State<FriendEditPage> {
  TextEditingController? _friendsnameController;
  TextEditingController? _DOBController;
  TextEditingController? _nicknameController;
  TextEditingController? _sexController;
  TextEditingController? _DescriptionController;
  TextEditingController? _phonenumberController;
  TextEditingController? _achivementsController;
  TextEditingController? _habbitsController;
  TextEditingController? _ImageController;
  DateTime? selectedDate;
  @override
  void initState() {
    _friendsnameController =
        TextEditingController(text: widget.friend.Friendsname);
    _DOBController = TextEditingController(text: widget.friend.DOB);
    _nicknameController = TextEditingController(text: widget.friend.nickname);
    _sexController = TextEditingController(text: widget.friend.sex);
    _DescriptionController =
        TextEditingController(text: widget.friend.description);
    _phonenumberController =
        TextEditingController(text: widget.friend.phonenumber);
    _achivementsController =
        TextEditingController(text: widget.friend.achivements);
    _habbitsController = TextEditingController(text: widget.friend.habbits);
    _ImageController =
        TextEditingController(text: widget.friend.friendprofilepic);
    super.initState();
  }

  @override
  void dispose() {
    _friendsnameController!.dispose();
    _DOBController!.dispose();
    _nicknameController!.dispose();
    _sexController!.dispose();
    _DescriptionController!.dispose();
    _phonenumberController!.dispose();
    _achivementsController!.dispose();
    _habbitsController!.dispose();
    _ImageController!.dispose();
    super.dispose();
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
        _DOBController?.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    // Check if the first letter is capitalized
    if (!RegExp(r'^[A-Z]').hasMatch(value)) {
      return 'First letter should be capitalized';
    }
    // Check if the name contains any special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Special characters are not allowed';
    }
    // Check if the name contains any numbers
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Numbers are not allowed in name';
    }
    return null;
  }

  String? validateNickname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Nickname';
    }
    // Check if the nickname contains any special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Special characters are not allowed in Nickname';
    }
    // Check if the nickname contains any numbers
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Numbers are not allowed in Nickname';
    }
    return null;
  }

  String? validateSex(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Sex';
    }

    // Convert the input to lowercase for case-insensitive comparison
    final lowerCaseValue = value.toLowerCase();

    // Check if the sex is either "male" or "female"
    if (lowerCaseValue != 'male' && lowerCaseValue != 'female') {
      return 'Only "Male" and "Female" are allowed';
    }

    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    // Check if the phone number contains any characters other than numbers
    if (RegExp(r'[^0-9]').hasMatch(value)) {
      return 'Only numbers are allowed in phone number';
    }
    return null;
  }

  String? validateAchievements(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter achievements';
    }
    // Check if the achievements contain any special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Special characters are not allowed in achievements';
    }
    // Check if the achievements contain any numbers
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Numbers are not allowed in achievements';
    }
    return null;
  }

  String? validateHabits(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter habits';
    }
    // Check if the habits contain any special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Special characters are not allowed in habits';
    }
    // Check if the habits contain any numbers
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Numbers are not allowed in habits';
    }
    return null;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EDIT"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _friendsnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "NAME",
                      hintText: 'Your Friend Name',
                    ),
                    validator: validateName,
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 150,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.friend.friendprofilepic!),
                        )),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10, top: 30),
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
                    height: 56,
                    padding: const EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xFFC2C2C2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            _DOBController!.text,
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Nick Name",
                      hintText: "Pet/Nick Name",
                    ),
                    validator: validateNickname,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _sexController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "SEX",
                      hintText: " Male/Female",
                    ),
                    validator: validateSex,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _DescriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "BRIEF DESCRIPTION",
                      hintText: "About your Friend",
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _phonenumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "PHONE NUMBER",
                      hintText: "Phone Number",
                    ),
                    validator: validatePhoneNumber,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _achivementsController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "ACHIVEMENTS",
                      hintText: "Goals Achived",
                    ),
                    validator: validateAchievements,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _habbitsController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "HABBITS",
                      hintText: "Good Habbits",
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    validator: validateHabits,
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        firestorehelper
                            .updatefriend(
                          FriendsUserModel(
                            id: widget.friend.id,
                            Friendsname: _friendsnameController!.text,
                            DOB: _DOBController!.text,
                            nickname: _nicknameController!.text,
                            sex: _sexController!.text,
                            description: _DescriptionController!.text,
                            phonenumber: _phonenumberController!.text,
                            achivements: _achivementsController!.text,
                            habbits: _habbitsController!.text,
                            fcmtoken: widget.friend.fcmtoken,
                            friendprofilepic: widget.friend.friendprofilepic,
                          ),
                        )
                            .then((value) {
                          Navigator.pop(context);
                        });
                      }
                      else{
                        showSnackBar(context, "Please check the data you have entered");
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.lightBlue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
