import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cube/Connectivity/connection_check.dart';
import 'package:my_cube/home/globalvar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final primaryColor = Colors.black;
  final secondaryColor = Colors.grey;
  late PageController pageController;// for tabs animation
  late ConnectionCheck _connectionCheck;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _connectionCheck=Get.find<ConnectionCheck>();
    //Start listening to network changes
    _connectionCheck.listenToNetworkChanges(context);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        child: PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            children:homeScreenItems,
        physics: NeverScrollableScrollPhysics(),),
        snackBar: SnackBar(
            content:Text(" Tap again to exit "),
        backgroundColor: Colors.grey,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? primaryColor : secondaryColor,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (_page == 1) ? primaryColor : secondaryColor,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: (_page == 2) ? primaryColor : secondaryColor,
              ),
              label: "Post"),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.people_alt_sharp,
                  color: (_page == 3) ? primaryColor : secondaryColor,
                ),
              label: "Social"),
          BottomNavigationBarItem(
              icon:  Icon(
                    Icons.account_circle_outlined,
                    color: (_page == 4) ? primaryColor : secondaryColor,
                  ),
              label: "Profile"),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
