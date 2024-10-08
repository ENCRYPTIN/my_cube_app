import 'dart:typed_data';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_cube/Widgets/text_field_input.dart';
import 'package:my_cube/home/homepage.dart';
import 'package:my_cube/screens/emaillogin.dart';
import 'package:my_cube/services/utils.dart';
import 'package:provider/provider.dart';
import 'package:my_cube/services/auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  TextEditingController countrycodeController = TextEditingController();
  String phonenumber = "";
  //to set default country code:
  Country country = CountryParser.parseCountryCode("IN");
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void initState() {
    getToken();
    super.initState();
  }

  String? fcmtoken = "";
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        fcmtoken = token;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _dobController.dispose();
    _phonenumberController.dispose();
    _bioController.dispose();
  }

  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }

  void signUpUser() async {
    final AuthProvider authService =
        Provider.of<AuthProvider>(context, listen: false);
    // set loading to true
    setState(() {
      _isLoading = true;
    });
    String phoneNumber = _phonenumberController.text.trim();
    // signup user using our authmethodds
    String res = await authService.signUpUser(
        phoneNumber: "+${country.phoneCode}$phoneNumber",
        email: _emailController.text,
        password: _passwordController.text,
        name: _usernameController.text,
        bio: _bioController.text,
        dateOfBirth: _dobController.text,
        fcmtoken: fcmtoken!,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      if (context.mounted) {
        authService
            .getUserDetails()
            .then((value) => authService.saveUserDataToSP())
            .then(
              (value) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  (route) => false),
            );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

//Validations
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    // Check if the name contains any special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Special characters are not allowed';
    }
    // Check if the name contains any numbers
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Numbers are not allowed';
    }
    return null;
  }

  String? validateText(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    // Check if the text contains any special characters
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Special characters are not allowed in $fieldName';
    }
    // Check if the text contains any numbers
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Numbers are not allowed in $fieldName';
    }
    return null;
  }

  String? validateNumber(String? value,) {
    if (value == null || value.isEmpty) {
      return 'Please enter Phone Number';
    }
    // Check if the value is a valid number
    if (value.length < 6) {
      return 'Must have at least 6 numbers';
    }
    return null;
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 1000,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                              backgroundColor: Colors.red,
                            )
                          : const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://i.stack.imgur.com/l60Hf.png'),
                              backgroundColor: Colors.red,
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldInput(
                    hintText: 'Enter your username',
                    textInputType: TextInputType.text,
                    textEditingController: _usernameController,
                    validator: validateName,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldInput(
                      hintText: 'Enter your email',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: _emailController,
                      validator: (value) {
                        // add email validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }

                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldInput(
                    hintText: 'Enter your password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: _isPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldInput(
                      hintText: 'Enter your bio',
                      textInputType: TextInputType.text,
                      textEditingController: _bioController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: 390,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: TextFormField(
                      validator: validateNumber,
                      cursorColor: Colors.purple,
                      controller: _phonenumberController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          phonenumber = value;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Enter phone number",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
                          margin: const EdgeInsets.only(top: 3),
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
                        suffixIcon: _phonenumberController.text.length > 9
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
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Select Date of Birth, using calender icon',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.1,
                                fontFamily: 'Inter'),
                          ),
                        ),
                      )),
                  Container(
                    width: 390,
                    height: 56,
                    padding: const EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xFFC2C2C2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            _dobController.text,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          flex: 7,
                        ),
                        Expanded(
                            flex: 3,
                            child: IconButton(
                                onPressed: () {
                                  _selectDate(context);
                                },
                                icon: Icon(Icons.calendar_month_outlined))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      if (_image != null) {
                        if (_formKey.currentState?.validate() ?? false) {
                          if(selectedDate!=null) {
                            signUpUser();
                          }else {
                            showSnackBar(context, "Please select Date of birth");
                          }
                        }
                      } else {
                        showSnackBar(context, "Please Upload a image");
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        color: Colors.lightBlueAccent,
                      ),
                      child: !_isLoading
                          ? const Text(
                              'Sign up',
                            )
                          : const CircularProgressIndicator(
                              color: Colors.indigoAccent,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'Already have an account?',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EmailLogin(),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(
                            ' Login.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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
