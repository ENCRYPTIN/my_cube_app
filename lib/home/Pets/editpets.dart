import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_cube/Models/petsusermodel.dart';
import 'package:my_cube/services/firestore_helper.dart';
import 'package:my_cube/services/utils.dart';

class EditPets extends StatefulWidget {
  final PetsUserModel pet;
  const EditPets({super.key, required this.pet});

  @override
  State<EditPets> createState() => _EditPetsState();
}

var firestorehelper = FirestoreHelper();

class _EditPetsState extends State<EditPets> {
  TextEditingController? _petsnameController;
  TextEditingController? _DOBController;
  TextEditingController? _HeightController;
  TextEditingController? _WeightController;
  TextEditingController? _DescriptionController;
  TextEditingController? _LicencenumberController;
  TextEditingController? _SexController;
  TextEditingController? _MedicalController;
  TextEditingController? _ImageController;
  DateTime? selectedDate;

  @override
  void initState() {
    _petsnameController = TextEditingController(text: widget.pet.Petsname);
    _DOBController = TextEditingController(text: widget.pet.DOB);
    _HeightController = TextEditingController(text: widget.pet.height);
    _WeightController = TextEditingController(text: widget.pet.weight);
    _DescriptionController =
        TextEditingController(text: widget.pet.description);
    _LicencenumberController =
        TextEditingController(text: widget.pet.licencenumber);
    _SexController = TextEditingController(text: widget.pet.sex);
    _MedicalController = TextEditingController(text: widget.pet.medicalhistory);
    _ImageController = TextEditingController(text: widget.pet.petprofilepic);
    super.initState();
  }

  @override
  void dispose() {
    _petsnameController!.dispose();
    _DOBController!.dispose();
    _HeightController!.dispose();
    _WeightController!.dispose();
    _DescriptionController!.dispose();
    _LicencenumberController!.dispose();
    _SexController!.dispose();
    _MedicalController!.dispose();
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

  String? validatePetname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a pet name';
    }

    if (RegExp(r'\d').hasMatch(value)) {
      return 'Numbers are not allowed';
    }

    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Special characters are not allowed';
    }

    if (!RegExp(r'^[A-Z]').hasMatch(value)) {
      return 'First letter should be capitalized';
    }

    return null;
  }

  String? validateHNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }

    if (double.tryParse(value) == null) {
      return 'Please enter a valid $fieldName';
    }

    return null;
  }

  String? validateWNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }

    if (double.tryParse(value) == null) {
      return 'Please enter a valid $fieldName';
    }

    return null;
  }

  String? validateLNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }

    if (int.tryParse(value) == null) {
      return 'Please enter a valid $fieldName';
    }

    return null;
  }

  String? validatesex(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter sex';
    }

    if (value.toLowerCase() != 'male' && value.toLowerCase() != 'female') {
      return 'Please enter either "Male" or "Female"';
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
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _petsnameController,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[300],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Pet Name",
                        hintText: 'Enter pet name',
                        labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        )),
                    validator: validatePetname,
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
                          image: NetworkImage(widget.pet.petprofilepic!),
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
                    controller: _HeightController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "HEIGHT",
                      hintText: "height in ft or inch",
                    ),
                    validator: (value) => validateHNumber(value, "HEIGHT"),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _WeightController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "WEIGHT",
                      hintText: "weight in kg",
                    ),
                    validator: (value) => validateWNumber(value, "WEIGHT"),
                    keyboardType: TextInputType.number,
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
                      hintText: "about your pet",
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _LicencenumberController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "LICENCE NUMBER",
                      hintText: "Licence Number of your Pet",
                    ),
                    validator: (value) =>
                        validateLNumber(value, "LICENCE NUMBER"),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _SexController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "SEX",
                      hintText: "Male OR Female",
                    ),
                    validator: validatesex,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _MedicalController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "MEDICAL HISTORY",
                      hintText: "Vet Details",
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        firestorehelper
                            .updatepet(
                          PetsUserModel(
                              id: widget.pet.id,
                              Petsname: _petsnameController!.text,
                              DOB: _DOBController!.text,
                              height: _HeightController!.text,
                              weight: _WeightController!.text,
                              description: _DescriptionController!.text,
                              licencenumber: _LicencenumberController!.text,
                              sex: _SexController!.text,
                              fcmtoken: widget.pet.fcmtoken,
                              medicalhistory: _MedicalController!.text,
                              petprofilepic: _ImageController!.text),
                        )
                            .then((value) {
                          Navigator.pop(context);
                        });
                      } else {
                        showSnackBar(context, "Please Enter all fields");
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
