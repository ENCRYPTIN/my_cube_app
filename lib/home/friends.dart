import 'package:flutter/material.dart';
class Friends extends StatelessWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      hintText: 'Your Friend Name',
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
                      labelText: "Nick Name",
                      hintText: "Pet/Nick Name",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "SEX",
                      hintText: " Male/Female",
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
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
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
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    maxLines: 3,
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
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => Family()));
                          },
                          child: Text('Click Me'),
                        );
                      }
                  ),
                ],
              ),
            ),
          )
          ),
        );
  }
}
