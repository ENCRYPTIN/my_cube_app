import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MY CUBE"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profilepage');
              },
              icon: Icon(Icons.account_circle_outlined)),
        ],
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
                borderRadius: BorderRadius.circular(26.0)),
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
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/friends');
              },
              child: Text(
                "Friends",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(26.0)),
          ),
          Container(
            height: 150,
            width: double.infinity,
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.circular(26.0),
              gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.orangeAccent,
                    Colors.red,
                    Colors.redAccent
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 0.2, 0.5, 0.8]),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pets');
              },
              child: Text(
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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
