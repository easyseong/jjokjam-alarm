import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18),
    ),
  );
}