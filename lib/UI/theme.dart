import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color plurpelColor = Color(0xFF4e5ae8);
const Color yellowlColor = Color(0xFFFFB764);
const Color pinkColor = Color(0xFFff4587);
const Color whiteColor = Colors.white;
const Color primaryColor = plurpelColor;
const Color greyColor = Color(0xFF121212);
const Color darkGreyColor = Color(0xFF424242);





class Themes{
  static final light= ThemeData(
    backgroundColor: whiteColor,
  primaryColor: primaryColor,
  brightness: Brightness.light,


  );
  static final dark= ThemeData(
    backgroundColor: darkGreyColor,


    primaryColor: darkGreyColor,

    brightness: Brightness.dark,

  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.grey:Colors.black,
    )


  );
}
TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      )


  );
}
TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode?Colors.white:Colors.black,
      )


  );
}

TextStyle get subtitleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode?Colors.grey[100]:Colors.grey[600],
      )


  );
}
