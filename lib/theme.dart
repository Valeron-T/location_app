// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// Define colours here. Make sure they are non nullable by default
var black = Color.fromARGB(255, 12, 12, 12);
var white = Color(0xFFFAFAFA);
var darkGrey = Color(0xFFEEEEEE);
var lightBlack = Color(0xFF303030);
var yellow = Color(0xFFFFC107);
var red = Color(0xFFF44336);
var green = Color(0xFF4CAF50);

// Light theme
var lightTheme = ThemeData(
  textTheme: TextTheme(bodyMedium: TextStyle(color: black)),
  iconTheme: IconThemeData(color: black),
  colorScheme:
      ColorScheme.light(background: darkGrey, primaryContainer: lightBlack ,primary: white, secondary: black),
  brightness: Brightness.light,
  fontFamily: 'Poppins',
);

// Dark Theme
var darkTheme = ThemeData(
  textTheme: TextTheme(bodyMedium: TextStyle(color: white)),
  iconTheme: IconThemeData(color: white),
  colorScheme: ColorScheme.dark(
      background: black, primary: lightBlack, primaryContainer: lightBlack, secondary: white),
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
);
