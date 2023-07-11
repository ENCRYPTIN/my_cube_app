import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_cube/screens/register_account.dart';
import 'package:my_cube/services/auth.dart';
import 'package:pinput/pinput.dart';
import 'package:my_cube/services/utils.dart';
import 'package:provider/provider.dart';
import 'package:my_cube/home/homepage.dart';
class Otp extends StatefulWidget {
  final String verificationId;
  const Otp({super.key, required this.verificationId});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _pinController = TextEditingController();
  String? otpCode;
  int start = 30;
  bool wait = false;
  void showOtpErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('OTP Error'),
          content: Text(errorMessage),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  Timer? _timer;
  @override
  void dispose() {
    _pinController.dispose();
    _timer?.cancel();
    super.dispose();
  }
@override
  void initState() {
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(117, 180, 245, 1.0)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
        body: SafeArea(
          child: isLoading == true
              ? const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          )
              :SingleChildScrollView(
                child: Center(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Container(
        width: 197,
        height: 50,
        margin: EdgeInsets.only(left: 15,top: 20),
        child: Text(
          'Verification code',
          style: TextStyle(
            fontSize: 24,
            letterSpacing: 0.01,
            color: Colors.black,
            fontFamily: 'Inter',
            height: 1.16, // You can adjust the line height by modifying this value
          ),
        ),
      ),
        Container(
          width: 292,
          height: 60,
          margin: EdgeInsets.only(left: 15, ),
          child: Text(
            'We have sent OTP code verification\nto your mobile no',
            style: TextStyle(
                fontSize: 16,
                letterSpacing: 0.01,
                color: Color(0xFF969696),
                fontFamily: 'Inter',
                height: 1.37, // You can adjust the line height by modifying this value
            ),
            textAlign: TextAlign.center,
          ),
        ),
          SizedBox(height: 150,),
          Text("Enter OTP",
          style: TextStyle(
            fontSize: 20
          ),),
          SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                length: 6,
                androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                controller: _pinController,
                onCompleted: (value) {
                  setState(() {
                    otpCode = value;
                  });
                },

            ),
          ),
        SizedBox(height: 15,),
        RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Send OTP again in ",
                  style: TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
                TextSpan(
                  text: "00:$start",
                  style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                ),
                TextSpan(
                  text: " sec ",
                  style: TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              ],
            )),
          SizedBox(height: 10,),
        Container(
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Text("Resend OTP",style: TextStyle(
              color: Colors.lightBlueAccent
            ),),
          ),
        ),
        SizedBox(height: 10,),
          Container(
            width: 347,
            height: 56,
            //padding: EdgeInsets.only(left: 15),
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  width: 2,
                  color: const Color(0xffB388FF),
                ),
            ),
            child: ElevatedButton(
                onPressed: () {
                  if (otpCode != null) {
                    verifyOtp(context, otpCode!);
                  } else {
                    showSnackBar(context, "Enter 6-Digit code");
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(347, 56),
                  backgroundColor: const Color(0xffB388FF),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
            ),
          )
      ],
    )),
              ),
        ));

  }
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingUser().then(
              (value) async {
            if (value == true) {
             //user exists in our app
              ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                      (value) => ap.setSignIn().then(
                        (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>const HomePage(),
                        ),
                            (route) => false),
                  ),
                ),
              );
            } else {
              // new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterAccount()),
                      (route) => false);
            }
          },
        );
      },
    );
  }
  void startTimer() {
    const onsec = Duration(seconds: 1);
     _timer = Timer.periodic(onsec, (timer) {
      if(context.mounted){
        if (start == 0) {
          setState(() {
            timer.cancel();
            wait = false;
          });
        } else {
          setState(() {
            start--;
          });
        }
      }
    });
  }
}
