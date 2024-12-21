import 'package:amizone_frontend/api/endpoints.dart';
import 'package:amizone_frontend/authentication/api/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:amizone_frontend/authentication/widgets/input_field.dart';
import 'package:amizone_frontend/authentication/widgets/text_input.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool sendRequest = false;

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  final Uri adminPageUri = Uri.parse(adminLoginURL);

  Future<void> _launchUrl() async {
    if (!await launchUrl(adminPageUri)) {
      throw Exception('Could not launch $adminPageUri');
    }
  }

  void _onLogin() async {
    String username = usernameController.text;
    String password = passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please Enter username & password"),
        duration: Duration(milliseconds: 500),
      ));
    } else {
      showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      onLogin(username, password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 14, 79, 146),
              Colors.white,
              Color.fromARGB(255, 208, 163, 30),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      'assets/images/amizone-logo-front.png',
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textInput(
                            text: "LOGIN",
                            size: 22,
                            weight: FontWeight.bold,
                            color: const Color.fromARGB(255, 20, 215, 10)),
                        textInput(
                            text: ' STUDENT | PARENT',
                            size: 20,
                            weight: FontWeight.bold,
                            color: const Color.fromARGB(255, 25, 72, 128))
                      ],
                    ),
                    TextButton(
                        onPressed: _launchUrl,
                        child: textInput(
                            text: 'Click here for admin login',
                            size: 14,
                            weight: FontWeight.w700,
                            color: const Color.fromARGB(255, 0, 0, 255))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Exam :',
                        ),
                        textInput(
                            text: 'https://oe.amizone.net',
                            size: 14,
                            weight: FontWeight.w700,
                            color: const Color.fromARGB(255, 0, 0, 255))
                      ],
                    ),
                    const SizedBox(height: 35),
                    inputField(
                        hintInput: "User Name",
                        obsecure: false,
                        icon: Icons.person_2,
                        controller: usernameController),
                    const SizedBox(height: 12),
                    inputField(
                        obsecure: true,
                        hintInput: "Password",
                        icon: Icons.lock,
                        controller: passwordController),
                    const SizedBox(height: 40),
                    ElevatedButton(
                        onPressed: _onLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 20, 215, 10),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: textInput(
                            text: "LOGIN",
                            size: 16,
                            weight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textInput(
                            text: "Forgot ",
                            size: 13,
                            weight: FontWeight.w500,
                            color: Colors.grey),
                        textInput(
                            text: 'Username/Password?',
                            size: 13,
                            color: Colors.black,
                            weight: FontWeight.w500),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/ranking.jpg',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
