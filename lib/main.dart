
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:my_cube/home/Family/family.dart';
import 'package:my_cube/home/Friends/friends.dart';
import 'package:my_cube/home/homepage.dart';
import 'package:my_cube/home/Pets/pets.dart';
import 'package:my_cube/home/profile.dart';
import 'package:my_cube/screens/register_account.dart';
import 'package:my_cube/screens/request_otp.dart';
import 'package:my_cube/services/auth.dart';
import 'package:my_cube/screens/welcome_screen.dart';
import 'Connectivity/connection_check.dart';
import 'firebase_options.dart';
import 'home/threewrapper.dart';
import 'screens/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<Connectivity>(Connectivity(), permanent: true);
  Get.put<ConnectionCheck>(ConnectionCheck(Get.find<Connectivity>()), permanent: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
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
        title: "My Cube",
        // home: _auth.currentUser!.uid==null?WelcomeScreen():HomePage(),
        initialRoute: '/',
        routes: {
         // '/': (context) => const Wrapper(),
          //'/': (context) => const SecWrapper(),
          '/': (context) => const ThreeWrapper(),
          '/new user': (context) => const WelcomeScreen(),
          '/login': (context) => const SignInPage2(),
          '/register_account': (context) => const RegisterAccount(),
          '/request_otp': (context) => const RequestOtp(),
          '/homepage': (context) => const HomePage(),
          '/profilepage': (context) => const Profile(),
          '/friends': (context) => const Friends(),
          '/family': (context) => const Family(),
          '/pets': (context) => const Pets(),
        },
      ),
    );
  }
}
