import 'package:flutter/material.dart';
class FamilyAdd extends StatefulWidget {
  const FamilyAdd({super.key});

  @override
  State<FamilyAdd> createState() => _FamilyAddState();
}

class _FamilyAddState extends State<FamilyAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "NAME",
                      hintText: 'Name of the Member',
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
                      labelText: "RELATIONSHIP",
                      hintText: "Relationship like father,mother,etc",
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "AGE",
                      hintText: "Age of the Member",
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "PHONE NUMBER",
                      hintText: "Phone Number",
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
                      labelText: "ACHIVEMENTS",
                      hintText: "Goals Achived",
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
                      hintText: "About your Friend",
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "HABBITS",
                      hintText: "Good Habbits",
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
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
                          child: const Text('Click Me'),
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
