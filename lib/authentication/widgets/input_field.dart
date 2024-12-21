import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget inputField(
    {required String hintInput,
    required IconData icon,
    required bool obsecure,
    required TextEditingController controller}) {
  return TextField(
    controller: controller,
    obscureText: obsecure,
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
