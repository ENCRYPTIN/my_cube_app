//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_cube/home/Profile.dart';
import 'package:my_cube/home/family.dart';
import 'package:my_cube/home/friends.dart';
import 'package:my_cube/home/homepage.dart';
import 'package:my_cube/home/pets.dart';
import 'package:my_cube/home/secwrapper.dart';
import 'package:my_cube/home/wrapper.dart';
import 'package:my_cube/screens/register_account.dart';
import 'package:my_cube/screens/request_otp.dart';
import 'package:my_cube/services/auth.dart';
import 'package:my_cube/screens/welcome_screen.dart';
import 'firebase_options.dart';
import 'screens/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
      await FirebaseAppCheck.instance.activate(
        webRecaptchaSiteKey: 'recaptcha-v3-site-key',
        androidProvider: AndroidProvider.playIntegrity,
  );
  runApp(const MyCube());
}
class MyCube extends StatefulWidget{
  const MyCube ({Key? key}) : super(key: key);

  @override
  State<MyCube> createState() => _MyCubeState();
}

class _MyCubeState extends State<MyCube> {
  @override
  Widget build(BuildContext context){
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_)=>AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: MyCube(),
        initialRoute: '/',
        routes: {
          //'/': (context) => const Wrapper(),
          '/': (context) => SecWrapper(),
          '/new user': (context) => const WelcomeScreen(),
          '/login': (context) => const SignInPage2(),
          '/register_account':(context)=>const RegisterAccount(),
          '/request_otp':(context)=>const RequestOtp(),
          '/homepage':(context)=>HomePage(),
          '/profilepage':(context)=>Proflie(),
          '/friends':(context)=>Friends(),
          '/family':(context)=>Family(),
          '/pets':(context)=>Pets(),
        },
      ),
    );
  }
}
