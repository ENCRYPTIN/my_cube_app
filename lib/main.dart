//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_cube/homepage.dart';
import 'package:my_cube/otp.dart';
import 'package:my_cube/register_account.dart';
import 'package:my_cube/request_otp.dart';
import 'package:my_cube/welcome_screen.dart';
import 'firebase_options.dart';
import 'login.dart';
// import 'package:firebase_auth/firebase_auth.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyCube());
}
class MyCube extends StatelessWidget{
  const MyCube ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      // home: MyCube(),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        // '/home': (context) => const HomePage(),
        '/login': (context) => const SignInPage2(),
        '/register_account':(context)=>const RegisterAccount(),
        '/request_otp':(context)=>const RequestOtp(),
        '/otp':(context)=>const Otp(),
        '/homepage':(context)=>const HomePage(),
      },
    );
  }
}
