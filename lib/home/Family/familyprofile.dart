import 'package:flutter/material.dart';
import 'package:my_cube/home/Family/family.dart';
import '../../services/utils.dart';
import 'package:my_cube/Models/familyusers.dart';
class FamilyProflie extends StatefulWidget {
  final FamilyUserModel family;
  const FamilyProflie({super.key, required this.family});
  @override
  State<FamilyProflie> createState() => _FamilyProflieState();
}
const kDefaultPadding=20.0;
class _FamilyProflieState extends State<FamilyProflie> {
  TextEditingController? _familynameController;
  TextEditingController? _DOBController;
  TextEditingController? _realtionshipController;
  TextEditingController? _ageController;
  TextEditingController? _descriptionController;
  TextEditingController? _habbitsController;
  TextEditingController? _phonenumberController;
  TextEditingController? _achivementsController;
  TextEditingController? _ImageController;
  @override
  void initState() {
    _familynameController = TextEditingController(text: widget.family.Familyname);
    _DOBController = TextEditingController(text: widget.family.DOB);
    _realtionshipController = TextEditingController(text: widget.family.relationship);
    _ageController = TextEditingController(text: widget.family.age);
    _descriptionController = TextEditingController(text: widget.family.description);
    _habbitsController = TextEditingController(text: widget.family.habbits);
    _phonenumberController = TextEditingController(text: widget.family.phonenumber);
    _achivementsController = TextEditingController(text: widget.family.achivements);
    _ImageController=TextEditingController(text: widget.family.familyprofilepic);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(kDefaultPadding*2),
                    bottomLeft: Radius.circular(kDefaultPadding*2)
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      maxRadius: 50.0,
                      minRadius: 50.0,
                      backgroundColor: Colors.white,
                      foregroundImage: NetworkImage(widget.family.familyprofilepic!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_familynameController!.text.toString(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Date of Birth',
                    value: _DOBController!.text.toString(),
                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Relationship',
                    value: _realtionshipController!.text,

                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Age',
                    value: _ageController!.text,
                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Description',
                    value: _descriptionController!.text,
                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Habbits',
                    value: _habbitsController!.text,
                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Phone Number',
                    value: _phonenumberController!.text,
                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Achivements',
                    value: _achivementsController!.text,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
