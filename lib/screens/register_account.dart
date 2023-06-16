import 'dart:io' as io;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_cube/Models/user_model.dart';
import 'package:my_cube/home/homepage.dart';
import 'package:my_cube/services/utils.dart';
import 'package:provider/provider.dart';
import 'package:my_cube/services/auth.dart';


class RegisterAccount extends StatefulWidget {
  const RegisterAccount({Key? key}) : super(key: key);
  @override
  State<RegisterAccount> createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  //final  fcmToken = await FirebaseMessaging.instance.getToken();
  //for validation
  String fcmtokenkey='fcmtokenkey';
  @override
  void initState() {
    getToken();
    super.initState();
  }
  String? fcmtoken="";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  io.File? image;
  final TextEditingController usernameController =TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void getToken() async{
    await FirebaseMessaging.instance.getToken().then(
        (token){
          setState(() {
            fcmtoken=token;
          });
        }
    );
  }


  DateTime? selectedDate;
  TextEditingController _dateController = TextEditingController();
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
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    _dateController.dispose();
  }

  String username='';
  String email='';

  // for selecting image
  void selectImage() async {
    image = await getImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return  Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        )
            : ListView(
          children: [Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: const Text(
                      'Register Account',
                  style:  TextStyle (
                      fontFamily: 'Poppins',
                      fontSize:  24,
                      fontWeight:  FontWeight.w500,
                      height:  1.0,
                      letterSpacing:  0.23,
                      color:  Colors.black,
                  ),
                  )),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      'Create your new MyCube Account.',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.01,
                        color: Color(0xFF969696),
                        fontFamily: 'Inter',
                        height: 1.26,
                      ),
                    ),
                  ),

                  //Image Container
                  Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: InkWell(
                      onTap: () => selectImage(),//selectImage(),
                      child: image == null
                          ? const CircleAvatar(
                        backgroundColor: Colors.purple,
                        radius: 60,
                        child: Icon(
                          Icons.account_circle,
                          size: 50,
                          color: Colors.white,
                        ),
                      )
                          : CircleAvatar(
                        backgroundImage: FileImage(image!),
                        radius: 50,
                      ),
                    ),
                  ),




                  //Name Text Container:
                  Container(
                      margin: const EdgeInsets.only(left: 10,top: 10),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('Enter Name',
                          textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.1,
                              fontFamily: 'Inter',
                            ),),
                        ),
                      )
                  ),
                  // Name Text field Container:
                  Container(
                    width: 390,
                    height: 56,
                    padding: const EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(left: 10,right: 10, top:10 ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xFFC2C2C2),
                      ),
                    ),
                    child:TextFormField(
                      controller: usernameController,
                      maxLines: 1,
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return "Name cannot be Empty";
                        }
                        return null;
                      },
                      textAlign: TextAlign.left,
                      onChanged: (val){
                        setState(() {
                          username=val;
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.account_circle_outlined),
                        hintText: 'Name',
                      ),
                    ),
                  ),
                  //Create Password Text Container:
                  Container(
                      margin: const EdgeInsets.only(left: 10,top: 30),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('Enter Mail ID',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.1,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      )
                  ),
                  // Password Text field Container:
                  Container(
                    width: 390,
                    height: 56,
                    padding: const EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(left: 10,right: 10, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xFFC2C2C2),
                      ),
                    ),
                    child:TextFormField(
                      maxLines: 1,
                      controller: emailController,
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }

                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      textAlign: TextAlign.left,
                      onChanged: (val){
                        setState(() {
                          email=val;
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Mail ID',
                        icon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  //bio Text Container
                  Container(
                      margin: const EdgeInsets.only(left: 10,top: 30),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('Select Date of Birth, using calender icon',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.1,
                              fontFamily: 'Inter'
                            ),
                          ),
                        ),
                      )
                  ),

                  // Retype Password Text field container
                  Container(
                    width: 390,
                    height: 56,
                    padding: const EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(left: 10,right: 10, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xFFC2C2C2),
                      ),
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Text(_dateController.text,),
                          flex: 7,
                        ),
                        Expanded(
                          flex: 3,
                            child: IconButton(onPressed: (){_selectDate(context);}, icon: Icon(Icons.calendar_month_outlined))),
                        // TextFormField(
                        //   readOnly: true,
                        //   controller: _dateController,
                        //   //maxLines: 1,
                        //   validator: (value){
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter date of birth';
                        //     }
                        //     return null;
                        //   },
                        //    onTap: () {
                        //    _selectDate(context);
                        //   },
                        //   textAlign: TextAlign.left,
                        //   decoration:const InputDecoration(
                        //     border: InputBorder.none,
                        //     labelText: 'Date of Birth',
                        //     hintText: 'dd/mm/yyyyy',
                        //     icon: Icon(Icons.calendar_month_outlined),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  //submit button Container
                  Container(
                    width: 347,
                    height: 56,
                    //padding: EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(left: 10,right: 10, top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xFF17FD54),
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                      storeData();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(347, 56),
                        backgroundColor: const Color(0xFF17FD54),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
  //save user data to database
 void storeData() async{
    //This line retrieves an instance of the AuthProvider class using the Provider package.
   // The Provider.of<T>() method is used to obtain the nearest ancestor of type T.
   // In this case, it's trying to get the AuthProvider instance.
   final AuthProvider authService = Provider.of<AuthProvider>(context, listen: false);
   UserModel userModel=UserModel(
       uid: "",
       username: usernameController.text,
       email: emailController.text,
       dateOfBirth: _dateController.text,
       profilepic: "",
       createdAt: "",
       phoneNumber: "",
     fcmtoken: fcmtoken!

   );

   if(image!=null){
     authService.saveUserDataToFirebase(
         context: context,
         userModel: userModel,
         profilePic: image!,
         onSuccess: (){
           authService.saveUserDataToSP().then(
                 (value) => authService.setSignIn().then(
                   (value) => Navigator.pushAndRemoveUntil(
                   context,
                   MaterialPageRoute(
                     builder: (context) => const HomePage(),
                   ),
                       (route) => false),
             ),
           );
         }
     );
   }else{
     showSnackBar(context, "Please upload your profile photo");
   }
  }
}
