import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class RequestOtp extends StatefulWidget {
  const RequestOtp({Key? key}) : super(key: key);
  static String verify="";
  @override
  State<RequestOtp> createState() => _RequestOtpState();
}

class _RequestOtpState extends State<RequestOtp> {
  TextEditingController phonenumberController=TextEditingController();
  TextEditingController countrycodeController=TextEditingController();
  String phonenumber="";
  @override
  void initState() {
    super.initState();
    countrycodeController.text="+91";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
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
                  margin: EdgeInsets.only(top: 10),
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
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image(
                      image: const AssetImage('assets/images/Myproject.png'),
                ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10,top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text('Enter Phone Number',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                            fontFamily: 'Inter',
                          ),),
                      ),
                    )
                ),
                Container(
                  width: 390,
                  height: 56,
                  padding: EdgeInsets.only(left: 15),
                  margin: EdgeInsets.only(left: 10,right: 10, top:10 ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      width: 2,
                      color: Color(0xFFC2C2C2),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Flexible(
                      flex:1,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: countrycodeController,

                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          '|',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 26,
                          ),
                    ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          controller: phonenumberController,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.left,
                          onChanged: (value){
                            phonenumber=value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //submit button Container
                Container(
                  width: 347,
                  height: 56,
                  //padding: EdgeInsets.only(left: 15),
                  margin: EdgeInsets.only(left: 10,right: 10, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      width: 2,
                      color: Color(0xFF17FD54),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () async{
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countrycodeController.text+phonenumber}',
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                            RequestOtp.verify=verificationId;
                          Navigator.pushNamed(context, '/otp',);
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );

                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: EdgeInsets.zero,
                      minimumSize: Size(347, 56),
                      backgroundColor: Color(0xFF22EA58),
                    ),
                    child: Text(
                      'Request OTP',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
