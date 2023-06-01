import 'package:flutter/material.dart';
class Family extends StatelessWidget {
  const Family({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: SafeArea(
    child: SingleChildScrollView(
    child: SingleChildScrollView(
    child: Container(
    margin: EdgeInsets.all(10),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    SizedBox(height: 8),
    TextFormField(
    decoration: InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    labelText: "NAME",
    hintText: 'Name of the Member',
    ),
    ),
    SizedBox(height: 16),
    Container(
    height: 150,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
    border: Border.all(
    color: Colors.black,
    width: 1.0,
    ),
    ),

    ), TextFormField(
    decoration: InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    labelText: "DATE OF BIRTH",
    hintText: "DOB",
    ),
    ),
    SizedBox(height: 16),
    TextFormField(
    decoration: InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    labelText: "RELATIONSHIP",
    hintText: "Relationship like father,mother,etc",
    ),
    ),
    SizedBox(height: 16),
    TextFormField(
    decoration: InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    labelText: "AGE",
    hintText: "Age of the Member",
    ),
    ),
    SizedBox(height: 16),
    TextFormField(

    decoration: InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    labelText: "PHONE NUMBER",
    hintText: "Phone Number",
    contentPadding: EdgeInsets.symmetric(vertical: 5),
    ),
    ),
    SizedBox(height: 16),
    TextFormField(
    maxLines: 2,
    decoration: InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    labelText: "ACHIVEMENTS",
    hintText: "Goals Achived",
    ),
    ),
    SizedBox(height: 16),
    TextFormField(
    maxLines: 5,
    decoration: InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    labelText: "BRIEF DESCRIPTION",
    hintText: "About your Friend",
    ),
    ),
    SizedBox(height: 16),
    TextFormField(
    maxLines: 2,
    decoration: InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    labelText: "HABBITS",
    hintText: "Good Habbits",
    contentPadding: EdgeInsets.symmetric(vertical: 5),
    ),
    ),
    Builder(
    builder: (context) {
    return ElevatedButton(
    onPressed: () {
    // Handle button click event
    // Add your logic or function call here
    //Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    },
    child: Text('Click Me'),
    );
    }
    ),
    ],
    ),
    ),

    ),
    ),
    ),
    );
  }
}
