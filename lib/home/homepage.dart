import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.00,
        title: const Text("MY CUBE",
        style: TextStyle(
          color: Colors.black87,
          fontFamily: 'Dancing Script',
          fontSize: 36,
          fontWeight: FontWeight.w600,

        ),),

      ),
      body: Center(
          child: Column(
        children: [
          Container(
            height: 150,
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
            child: TextButton(
              child: const Text(
                "Family",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/family');
              },
            ),
          ),
          Container(
            height: 150,
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
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/friends');
              },
              child: const Text(
                "Friends",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            height: 150,
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
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pets');
              },
              child: const Text(
                "Pets",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: IconButton(onPressed: (){
                Navigator.pushNamed(context, '/profilepage');
              }, icon: Icon(Icons.account_circle_outlined)), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
