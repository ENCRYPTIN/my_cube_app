import 'package:flutter/material.dart';
class RegisterAccount extends StatelessWidget {
  const RegisterAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(
        children: [Center(
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
              //Name Text Container:
              Container(
                  margin: const EdgeInsets.only(left: 10,top: 110),
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
                child: const TextField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
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
                      child: Text('Create Password',
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
                child: const TextField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                  ),
                ),
              ),
              //Confirm Password Text Container
              Container(
                  margin: const EdgeInsets.only(left: 10,top: 30),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text('Cofirm Password',
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
                child: const TextField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Retype Password',
                  ),
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
                    Navigator.pushNamed(context, '/homepage');
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
      ]),
    );
  }
}
