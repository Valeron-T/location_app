// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// Define colours here. Make sure they are non nullable by default
var black = Color.fromARGB(255, 12, 12, 12);
var white = Color(0xFFFAFAFA);
var darkGrey = Color.fromARGB(255, 219, 219, 219);
var lightBlack = Color(0xFF303030);
var yellow = Color(0xFFFFC107);
var red = Color(0xFFF44336);
var green = Color(0xFF4CAF50);

// Light theme
var lightTheme = ThemeData(
  textTheme: TextTheme(bodyMedium: TextStyle(color: black), headlineSmall: TextStyle(color: white)),
  iconTheme: IconThemeData(color: black),
  colorScheme: ColorScheme.light(
      background: darkGrey,
      primaryContainer: Color(0xFF6E6E6E),
      secondaryContainer: Color(0xFF6E6E6E),
      primary: white,
      secondary: black),
  brightness: Brightness.light,
  fontFamily: 'Poppins',
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 1.5, color: white),
      borderRadius: BorderRadius.circular(100),
    ),
  ),
);

// Dark Theme
var darkTheme = ThemeData(
  textTheme: TextTheme(bodyMedium: TextStyle(color: white)),
  iconTheme: IconThemeData(color: white),
  colorScheme: ColorScheme.dark(
      background: black,
      primary: lightBlack,
      primaryContainer: lightBlack,
      secondaryContainer: lightBlack,
      secondary: white),
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 1.5, color: white),
      borderRadius: BorderRadius.circular(100),
    ),
  ),
);
