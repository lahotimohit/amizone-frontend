import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textInput(
    {required String text,
    required double size,
    required FontWeight weight,
    required Color color}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: weight,
    ),
  );
}
