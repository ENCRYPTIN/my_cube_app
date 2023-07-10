import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
class RiveTest extends StatefulWidget {
  const RiveTest({super.key});

  @override
  State<RiveTest> createState() => _RiveTestState();
}

class _RiveTestState extends State<RiveTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
          children: [
            rive.RiveAnimation.asset("assets/rive/cubeshape.riv"),
            Positioned.fill(child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
              child: SizedBox(),
            )),
            ListView(
                children: [Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/family');
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4,
                            width: double.infinity,
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.circular(26.0),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xfffce4ec),
                                    Color(0xfff8bbd0),
                                    Color(0xffa3bef8),
                                    Color(0xff99b0fc),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0, 0.2, 0.5, 0.8]),
                            ),
                            child: Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: SizedBox(
                                      width: 120,
                                      child: Image(
                                        image: AssetImage("assets/images/familyblack.png"),
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "Family",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/friends');
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4,
                            width: double.infinity,
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.circular(26.0),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xfffce4ec),
                                    Color(0xfff8bbd0),
                                    Color(0xffa3bef8),
                                    Color(0xff99b0fc)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0, 0.2, 0.5, 0.8]),
                            ),
                            child: Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: SizedBox(
                                      width: 120,
                                      child: Image(
                                        image: AssetImage("assets/images/friendsblack.png"),
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "Friends",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/pets');
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4,
                            width: double.infinity,
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.circular(26.0),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xfffce4ec),
                                    Color(0xfff8bbd0),
                                    Color(0xffa3bef8),
                                    Color(0xff99b0fc)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0, 0.2, 0.5, 0.8]),
                            ),
                            child: Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: SizedBox(
                                      width: 120,
                                      child: Image(
                                        image: AssetImage("assets/images/dogdark.png"),
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "Pets",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                ]),
          ]),
    );
  }
}
