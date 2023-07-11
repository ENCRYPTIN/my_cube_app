import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:my_cube/screens/emaillogin.dart';
import 'package:rive/rive.dart' as rive;
import 'dart:ui';
//import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  bool isRegisterLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:DoubleBackToCloseApp(
          snackBar: SnackBar(content: Text(" Tap Again to Exit"),),
          child: Center(
              child: Stack(
                children: [
                  rive.RiveAnimation.asset("assets/rive/cubeshape.riv"),
                  Positioned.fill(child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
                    child: SizedBox(),
                  )),
                  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin:  const EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 10.0),
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        'MY CUBE',
                        style:  TextStyle (
                          fontFamily: 'Dancing Script',
                          fontSize:  46,
                          fontWeight:  FontWeight.w700,
                          height:  1.5,
                          letterSpacing:  0.23,
                          color:  Color(0xff2d49dc),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 180,
                        width: 180,
                        child: Image.asset('assets/images/cubepinkish.png'),

                    ),
                    Container(
                      width:  double.infinity,
                      height:  56,
                      margin: const EdgeInsets.all(20),
                      decoration:  BoxDecoration (
                          color:  const Color(0xffB388FF), //c44aec),E040FB
                          borderRadius:  BorderRadius.circular(100,)
                      ),
                      child:TextButton(
                        child: const Text('Register',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize:  16,
                            fontWeight:  FontWeight.w700,
                            height:  1.2125,
                            letterSpacing:  0.08,
                            color:  Color(0xffffffff),
                          ),),
                        onPressed: () {

                          Navigator.pushNamed(context, '/request_otp');

                        },
                      ),
                    ),
                    Container(
                      width:  double.infinity,
                      height:  56,
                      margin: const EdgeInsets.all(20),
                      decoration:  BoxDecoration (
                          color:  const Color(0xffB388FF),
                          borderRadius:  BorderRadius.circular(100,)
                      ),
                      child:
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailLogin()));
                        },
                        child:
                        const Text('Email Register ',
                          style: TextStyle (
                            fontFamily: 'Poppins',
                            fontSize:  16,
                            fontWeight:  FontWeight.w700,
                            height:  1.2125,
                            letterSpacing:  0.08,
                            color:  Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ])
          ),
        )
    );

  }
}
