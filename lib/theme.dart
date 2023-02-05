// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// Define colours here. Make sure they are non nullable by default
var black = Colors.black;
var white = Color(0xFFFAFAFA);
var darkGrey = Color(0xFFEEEEEE);
var lightBlack = Color(0xFF303030);

// Light theme
var lightTheme = ThemeData(
  textTheme: TextTheme(bodyMedium: TextStyle(color: black)),
  iconTheme: IconThemeData(color: black),
  colorScheme:
      ColorScheme.light(background: darkGrey, primary: white, secondary: black),
  brightness: Brightness.light,
  fontFamily: 'Poppins',
);

// Dark Theme
var darkTheme = ThemeData(
  textTheme: TextTheme(bodyMedium: TextStyle(color: white)),
  iconTheme: IconThemeData(color: white),
  colorScheme: ColorScheme.dark(
      background: black, primary: lightBlack, secondary: white),
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
);
