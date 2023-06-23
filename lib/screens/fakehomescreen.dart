import 'package:flutter/material.dart';
class FakeHomeScreen extends StatefulWidget {
  const FakeHomeScreen({super.key});

  @override
  State<FakeHomeScreen> createState() => _FakeHomeScreenState();
}

class _FakeHomeScreenState extends State<FakeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text("LOGGED IN")),
    );
  }
}
