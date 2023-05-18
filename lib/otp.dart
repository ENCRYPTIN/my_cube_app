import 'package:flutter/material.dart';
class Otp extends StatelessWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
            width: 390,
            height: 56,
            padding: EdgeInsets.only(left: 15),
            margin: EdgeInsets.only(left: 10,right: 10, top:150 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
              width: 2,
              color: Color(0xFFC2C2C2),
    ),
    ),

                child: TextField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'OTP',
                  ),

              ),
      ),

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
              onPressed: () {
                Navigator.pushNamed(context, '/register_account');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: EdgeInsets.zero,
                minimumSize: Size(347, 56),
                backgroundColor: Color(0xFF17FD54),
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          )
      ],
    )
      )
    );
  }
}
