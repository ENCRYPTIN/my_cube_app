import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_cube/Models/familyusers.dart';
import 'package:my_cube/services/firestore_helper.dart';
import 'package:my_cube/services/utils.dart';

class EditFamily extends StatefulWidget {
  final FamilyUserModel family;
  const EditFamily({super.key, required this.family});

  @override
  State<EditFamily> createState() => _EditFamilyState();
}

var firestorehelper = FirestoreHelper();

class _EditFamilyState extends State<EditFamily> {
  TextEditingController? _familynameController;
  TextEditingController? _DOBController;
  TextEditingController? _realtionshipController;
  TextEditingController? _ageController;
  TextEditingController? _descriptionController;
  TextEditingController? _habbitsController;
  TextEditingController? _phonenumberController;
  TextEditingController? _achivementsController;
  TextEditingController? _ImageController;
  DateTime? selectedDate;
  @override
  void initState() {
    _familynameController =
        TextEditingController(text: widget.family.Familyname);
    _DOBController = TextEditingController(text: widget.family.DOB);
    _realtionshipController =
        TextEditingController(text: widget.family.relationship);
    _ageController = TextEditingController(text: widget.family.age);
    _descriptionController =
        TextEditingController(text: widget.family.description);
    _habbitsController = TextEditingController(text: widget.family.habbits);
    _phonenumberController =
        TextEditingController(text: widget.family.phonenumber);
    _achivementsController =
        TextEditingController(text: widget.family.achivements);
    _ImageController =
        TextEditingController(text: widget.family.familyprofilepic);
    super.initState();
  }

  @override
  void dispose() {
    _familynameController!.dispose();
    _DOBController!.dispose();
    _realtionshipController!.dispose();
    _ageController!.dispose();
    _descriptionController!.dispose();
    _habbitsController!.dispose();
    _phonenumberController!.dispose();
    _achivementsController!.dispose();
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

  String? validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    // Check if the value is a valid number
    if (int.tryParse(value) == null) {
      return 'Please enter a valid $fieldName';
    }
    return null;
  }

  String? validateRelationship(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a relationship';
    }
    // Check if the relationship contains any special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Special characters are not allowed in relationship';
    }
    // Check if the relationship contains any numbers
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Numbers are not allowed in relationship';
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
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _familynameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "NAME",
                      hintText: 'Name of the Member',
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
                          image: NetworkImage(widget.family.familyprofilepic!),
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
                    controller: _realtionshipController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "RELATIONSHIP",
                      hintText: "Relationship like father,mother,etc",
                    ),
                    validator: validateRelationship,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "AGE",
                      hintText: "Age of the Member",
                    ),
                    validator: (value) => validateNumber(value, "age"),
                    keyboardType: TextInputType.number,
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
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    validator: (value) =>
                        validateNumber(value, "phone number"),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _achivementsController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "ACHIVEMENTS",
                      hintText: "Goals Achived",
                    ),
                      validator: validateAchievements
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "BRIEF DESCRIPTION",
                      hintText: "About your Friend",
                    ),
                    validator: (value) =>
                        validateText(value, "brief description"),
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
                      if(_formKey.currentState?.validate() ?? false){
                        firestorehelper
                            .updatefamily(
                          FamilyUserModel(
                              id: widget.family.id,
                              Familyname: _familynameController!.text,
                              DOB: _DOBController!.text,
                              relationship: _realtionshipController!.text,
                              age: _ageController!.text,
                              description: _descriptionController!.text,
                              phonenumber: _phonenumberController!.text,
                              achivements: _achivementsController!.text,
                              habbits: _habbitsController!.text,
                              fcmtoken: widget.family.fcmtoken,
                              familyprofilepic: _ImageController!.text),
                        )
                            .then((value) {
                          Navigator.pop(context);
                        });
                      }
                      else{
                        showSnackBar(context, "Please Enter Your Details");
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
