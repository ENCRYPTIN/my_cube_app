import 'package:flutter/material.dart';
import 'package:my_cube/Models/friendsusers.dart';
import 'package:my_cube/services/utils.dart';
class FriendsProfile extends StatefulWidget {
  final FriendsUserModel friends;
  const FriendsProfile({super.key,required this.friends});
  @override
  State<FriendsProfile> createState() => _FriendsProfileState();
}
const kDefaultPadding=20.0;
class _FriendsProfileState extends State<FriendsProfile> {
  TextEditingController? _friendsnameController;
  TextEditingController? _DOBController;
  TextEditingController? _nicknameController;
  TextEditingController? _sexController;
  TextEditingController? _DescriptionController;
  TextEditingController? _phonenumberController;
  TextEditingController? _achivementsController;
  TextEditingController? _habbitsController;
  TextEditingController? _ImageController;
  @override
  void initState() {
    _friendsnameController = TextEditingController(text: widget.friends.Friendsname);
    _DOBController = TextEditingController(text: widget.friends.DOB);
    _nicknameController = TextEditingController(text: widget.friends.nickname);
    _sexController = TextEditingController(text: widget.friends.sex);
    _DescriptionController = TextEditingController(text: widget.friends.description);
    _habbitsController = TextEditingController(text: widget.friends.habbits);
    _phonenumberController = TextEditingController(text: widget.friends.phonenumber);
    _achivementsController = TextEditingController(text: widget.friends.achivements);
    _ImageController=TextEditingController(text: widget.friends.friendprofilepic);
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
                      foregroundImage: NetworkImage(widget.friends.friendprofilepic!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_friendsnameController!.text.toString(),
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
                    label: 'Nickname',
                    value: _nicknameController!.text,

                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Sex',
                    value: _sexController!.text,
                  ),
                  UserInfoTile(
                    //margin: EdgeInsets.only(bottom: 16),
                    label: 'Description',
                    value: _DescriptionController!.text,
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
