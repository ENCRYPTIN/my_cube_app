//import 'dart:js';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_cube/home/Profile.dart';
import 'package:my_cube/home/family.dart';
import 'package:my_cube/home/friends.dart';
import 'package:my_cube/home/homepage.dart';
import 'package:my_cube/home/pets.dart';
import 'package:my_cube/home/secwrapper.dart';
import 'package:my_cube/screens/register_account.dart';
import 'package:my_cube/screens/request_otp.dart';
import 'package:my_cube/services/auth.dart';
import 'package:my_cube/screens/welcome_screen.dart';
import 'Models/user_model.dart';
import 'firebase_options.dart';
import 'screens/login.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_app_check/firebase_app_check.dart';

//import 'dart:async';

//import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyCube());
}

class MyCube extends StatefulWidget {
  const MyCube({Key? key}) : super(key: key);

  @override
  State<MyCube> createState() => _MyCubeState();
}

class _MyCubeState extends State<MyCube> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: MyCube(),
        initialRoute: '/',
        routes: {
          //'/': (context) => const Wrapper(),
          '/': (context) => const SecWrapper(),
          '/new user': (context) => const WelcomeScreen(),
          '/login': (context) => const SignInPage2(),
          '/register_account': (context) => const RegisterAccount(),
          '/request_otp': (context) => const RequestOtp(),
          '/homepage': (context) => const HomePage(),
          '/profilepage': (context) => const Proflie(),
          '/friends': (context) => const Friends(),
          '/family': (context) => const Family(),
          '/pets': (context) => const Pets(),
        },
      ),
    );
  }
}
