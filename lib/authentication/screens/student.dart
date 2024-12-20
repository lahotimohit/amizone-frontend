import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StugentLogin extends StatefulWidget {
  const StugentLogin({super.key});

  @override
  State<StugentLogin> createState() => _StugentLoginState();
}

class _StugentLoginState extends State<StugentLogin> {
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
                        Text(
                          'LOGIN ',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            color: const Color.fromARGB(255, 20, 215, 10),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'STUDENT | PARENT',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 25, 72, 128),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Click here for admin login',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 0, 0, 255),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Exam :',
                        ),
                        Text(
                          'https://oe.amizone.net',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 0, 0, 255),
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    inputField(hintInput: "User Name", icon: Icons.person_2),
                    const SizedBox(height: 12),
                    inputField(hintInput: "Password", icon: Icons.lock),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 20, 215, 10),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'LOGIN',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Forgot ',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Username/Password?',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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

Widget inputField({required String hintInput, required IconData icon}) {
  return TextField(
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white70,
      prefixIcon: Icon(
        icon,
        color: const Color.fromARGB(255, 130, 130, 130),
      ),
      hintText: hintInput,
      hintStyle: GoogleFonts.poppins(
          fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
