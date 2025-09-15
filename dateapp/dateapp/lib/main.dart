import 'package:dateapp/screen/homeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme:ThemeData(
        fontFamily: 'sunflower',
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'parisienne'
          ),
           displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'parisienne'
          ),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 30.0),
          bodyMedium: TextStyle(color: Colors.white,fontSize: 20.0),
        )
      ),
      home: HomeScrren(),
    )
  );
}

