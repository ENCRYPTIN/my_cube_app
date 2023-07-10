import 'package:flutter/material.dart';
class NoNetwork extends StatefulWidget {
  const NoNetwork({super.key});

  @override
  State<NoNetwork> createState() => _NoNetworkState();
}

class _NoNetworkState extends State<NoNetwork> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("No Network"),
      ),
    );
  }
}
