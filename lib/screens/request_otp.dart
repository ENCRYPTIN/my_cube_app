
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:my_cube/services/auth.dart';
import 'package:provider/provider.dart';
class RequestOtp extends StatefulWidget {
  const RequestOtp({Key? key}) : super(key: key);
  static String verify="";
  @override
  State<RequestOtp> createState() => _RequestOtpState();
}

class _RequestOtpState extends State<RequestOtp> {
  TextEditingController phoneController=TextEditingController();
  TextEditingController countrycodeController=TextEditingController();
  //to set default country code:
  Country country=CountryParser.parseCountryCode("IN");
  String phonenumber="";
  String phonenumbersend="";
  List<String> logs = [];
  bool isRegisterLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                    child: const Text(
                      'Register Account',
                      style:  TextStyle (
                        fontFamily: 'Poppins',
                        fontSize:  24,
                        fontWeight:  FontWeight.w500,
                        height:  1.0,
                        letterSpacing:  0.23,
                        color:  Colors.black,
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Create your new MyCube Account.',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.01,
                      color: Color(0xFF969696),
                      fontFamily: 'Inter',
                      height: 1.26,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 200,
                  width: 200,
                  child: Image(
                      image: AssetImage('assets/images/Myproject.png'),
                ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 10,top: 20),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text('Enter Phone Number',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                            fontFamily: 'Inter',
                          ),),
                      ),
                    )
                ),
                Container(
                  width: 390,
                  height: 56,
                  padding: const EdgeInsets.only(left: 15),
                  margin: const EdgeInsets.only(left: 10,right: 10, top:10 ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child:    TextFormField(
                    cursorColor: Colors.purple,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        phonenumber = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.grey.shade600,

                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(top:3),

                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    country = value;
                                  });
                                });
                          },
                          child: Text(
                            "${country.flagEmoji} + ${country.phoneCode}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      suffixIcon: phoneController.text.length > 9
                          ? Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                          : null,
                    ),
                  ),
                ),

                //submit button Container
                Container(
                  width: 347,
                  height: 56,
                  //padding: EdgeInsets.only(left: 15),
                  margin: const EdgeInsets.only(left: 10,right: 10, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      width: 2,
                      color: const Color(0xffB388FF),
                    ),
                  ),

                  child:ElevatedButton(
                    onPressed: () async{
                      sendPhoneNumber();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(347, 56),
                      backgroundColor: const Color(0xffB388FF),
                    ),
                    child: const Text(
                      'Request OTP',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              ],
            )
        ),
      ),
    );

  }
  void sendPhoneNumber() {
    final AuthProvider authService = Provider.of<AuthProvider>(
        context, listen: false);
    String phoneNumber = phoneController.text.trim();
    FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);

    authService.signInWithPhone(context, "+${country.phoneCode}$phoneNumber");
  }
}
