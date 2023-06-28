import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_cube/home/homepage.dart';
import 'package:my_cube/screens/forgotpassword.dart';
import 'package:my_cube/screens/signupscreen.dart';
import 'package:my_cube/services/utils.dart';
import 'package:provider/provider.dart';
import 'package:my_cube/services/auth.dart';
import '../Widgets/text_field_input.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    final AuthProvider authService =
        Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });
    String res = await authService.loginUser(
        email: _emailController.text.trim(), password: _passwordController.text);
    if (res == 'success') {
      //authService.getUserDetails().then((value) => authService.saveUserDataToSP());
      if (context.mounted) {
        authService.getUserDetails().then((value) => authService
            .saveUserDataToSP()
            .then((value) => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false)));
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }
  final GlobalKey<FormState> _formKEY = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Form(
              key: _formKEY,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 150,),
                  SvgPicture.asset(
                    color: const Color(0xffB388FF),'assets/images/Cube.svg',
                    height: 64,
                  ),
                  const SizedBox(
                    height: 64,
                  ),
              TextFormField(
                controller: _emailController,
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
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                  filled: true,
                ),
              ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        border: OutlineInputBorder(
                          borderSide: Divider.createBorderSide(context),
                        ),
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword())),
                        child: Text("Forgot Password?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.lightBlue
                        ),),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap:() {
                      if (_formKEY.currentState?.validate() ??
                          false) {
                        loginUser();
                      }
                    } ,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        color: const Color(0xffB388FF),
                      ),
                      child: !_isLoading
                          ? const Text(
                              'Log in',
                            )
                          : const CircularProgressIndicator(
                              color: const Color(0xFF000000),
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
                          'Dont have an account?',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(
                            ' Signup.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent
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
