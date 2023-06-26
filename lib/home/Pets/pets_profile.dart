import 'package:flutter/material.dart';
import 'package:my_cube/Models/petsusermodel.dart';
import 'package:my_cube/services/utils.dart';
class PetsProfile extends StatefulWidget {
  final PetsUserModel pets;
  const PetsProfile({super.key,required this.pets});
  @override
  State<PetsProfile> createState() => _PetsProfileState();
}
const kDefaultPadding=20.0;
class _PetsProfileState extends State<PetsProfile> {
  TextEditingController? _petsnameController;
  TextEditingController? _DOBController;
  TextEditingController? _HeightController;
  TextEditingController? _WeightController;
  TextEditingController? _DescriptionController;
  TextEditingController? _LicencenumberController;
  TextEditingController? _SexController;
  TextEditingController? _MedicalController;
  TextEditingController? _ImageController;
  @override
  void initState() {
    _petsnameController = TextEditingController(text: widget.pets.Petsname);
    _DOBController = TextEditingController(text: widget.pets.DOB);
    _HeightController = TextEditingController(text: widget.pets.height);
    _WeightController = TextEditingController(text: widget.pets.weight);
    _DescriptionController = TextEditingController(text: widget.pets.description);
    _LicencenumberController = TextEditingController(text: widget.pets.licencenumber);
    _SexController = TextEditingController(text: widget.pets.sex);
    _MedicalController = TextEditingController(text: widget.pets.medicalhistory);
    _ImageController=TextEditingController(text: widget.pets.petprofilepic);
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
                      foregroundImage: NetworkImage(widget.pets.petprofilepic!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_petsnameController!.text.toString(),
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
                    label: 'Height',
                    value: _HeightController!.text,
                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Weight',
                    value: _WeightController!.text,
                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Description',
                    value: _DescriptionController!.text,
                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Liscence No.',
                    value: _LicencenumberController!.text,
                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Gender',
                    value: _SexController!.text,
                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Previous Medical History',
                    value: _MedicalController!.text,
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
