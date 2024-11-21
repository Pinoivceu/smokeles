import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle headline = GoogleFonts.quicksand(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  static final TextStyle h2WithFill = GoogleFonts.quicksand(
    textStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white, // Warna isi teks
    ),
  );
}





