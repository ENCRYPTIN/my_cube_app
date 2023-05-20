import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:  EdgeInsets.fromLTRB(9.0, 0.0, 0.0, 10.0),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'MY CUBE',
                    style:  TextStyle (
                      fontFamily: 'Poppins',
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
                    child: SvgPicture.asset('assets/images/Cube.svg'),

                ),
                Container(
                  width:  double.infinity,
                  height:  56,
                  margin: EdgeInsets.all(20),
                  decoration:  BoxDecoration (
                      color:  Color(0xff10fc44),
                      borderRadius:  BorderRadius.circular(100,)
                  ),
                  child: TextButton(
                    child: Text('Register',
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
                  margin: EdgeInsets.all(20),
                  decoration:  BoxDecoration (
                      color:  Color(0xff10fc44),
                      borderRadius:  BorderRadius.circular(100,)
                  ),
                  child:
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child:
                      Text('Login ',
                        style: TextStyle (
                          fontFamily: 'Poppins',
                          fontSize:  16,
                          fontWeight:  FontWeight.w700,
                          height:  1.2125,
                          letterSpacing:  0.08,
                          color:  const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
        )
    );

  }
}
