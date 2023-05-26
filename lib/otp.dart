import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_cube/request_otp.dart';
import 'package:pinput/pinput.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _digit1Controller = TextEditingController();
  final TextEditingController _digit2Controller = TextEditingController();
  final TextEditingController _digit3Controller = TextEditingController();
  final TextEditingController _digit4Controller = TextEditingController();
  final TextEditingController _digit5Controller = TextEditingController();
  final TextEditingController _digit6Controller = TextEditingController();

  final TextEditingController _pinController = TextEditingController();

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

  @override
  void dispose() {
    _digit1Controller.dispose();
    _digit2Controller.dispose();
    _digit3Controller.dispose();
    _digit4Controller.dispose();
    _digit5Controller.dispose();
    _digit6Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
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
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Pinput(
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            // validator: (s) {
            //   return s == '2222' ? null : 'Pin is incorrect';
            // },
            // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            length: 6,
            androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
            controller: _pinController,
            // onCompleted: (pin) => print(pin),
          ),
        ),
        Container(
          width: 347,
          height: 56,
          //padding: EdgeInsets.only(left: 15),
          margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              width: 2,
              color: const Color(0xFF17FD54),
            ),
          ),
          child: ElevatedButton(
            onPressed: () async {
              try {
                //showOtpErrorDialog(context, _digit1Controller.text+_digit2Controller.text+_digit3Controller.text+_digit4Controller.text+_digit5Controller.text+_digit6Controller.text,);
                // Create a PhoneAuthCredential with the code
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: RequestOtp.verify,
                    smsCode: _pinController.text);
                //smsCode:_digit1Controller.text+_digit2Controller.text+_digit3Controller.text+_digit4Controller.text+_digit5Controller.text+_digit6Controller.text );
                // Sign the user in (or link) with the credential
                await auth.signInWithCredential(credential);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/register_account', (route) => false);
              } catch (e) {
                showOtpErrorDialog(context, e.toString());
              }
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
              'Submit',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    )));
  }
}
