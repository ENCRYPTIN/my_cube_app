import 'package:flutter/material.dart';
class PetsAdd extends StatefulWidget {
  const PetsAdd({super.key});

  @override
  State<PetsAdd> createState() => _PetsAddState();
}

class _PetsAddState extends State<PetsAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.lightBlue,Colors.lightBlueAccent,Colors.indigoAccent],
                  begin: Alignment.topLeft,end: Alignment.bottomRight,stops: [0.1, 0.4, 0.6,]
              ),
            ),
            margin: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                      fillColor:Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Pet Name",
                      hintText: 'Enter your name',
                      labelStyle:const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 150,
                  margin: const EdgeInsets.all(10),
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
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "HEIGHT",
                    hintText: "height in ft or inch",
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "WEIGHT",
                    hintText: "weight in kg",
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "BRIEF DESCRIPTION",
                    hintText: "about your pet",
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "LICENCE NUMBER",
                    hintText: "Licence Number of your Pet",
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "SEX",
                    hintText: "Male OR Female",
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "MEDICAL HISTORY",
                    hintText: "Vet Details",
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ),
                Builder(
                    builder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          // Handle button click event
                          // Add your logic or function call here
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Friend()));
                        },
                        child: const Text('Click Me'),
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
