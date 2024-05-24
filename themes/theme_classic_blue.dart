

import 'package:flutter/material.dart';
ThemeData ClassicMode = 
ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white54,
  ),
  shadowColor: Color.fromARGB(110, 112, 201, 228),
  indicatorColor: Color.fromARGB(106, 67, 240, 202),
  cardTheme: CardTheme(
    color: Color.fromRGBO(255, 255, 255, 75),
    surfaceTintColor: Color.fromARGB(118, 195, 181, 204)
  ),
  textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black87) ,bodyMedium: TextStyle(color: Colors.black45)),
  iconTheme: IconThemeData(
    color: Colors.black38
  ),
    appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 188, 203, 222),
      titleTextStyle: TextStyle(color: Colors.black),
      centerTitle: true,
      shape:LinearBorder(),),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 188, 203, 222)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 194, 221, 230),
        dividerColor: Color.fromARGB(255, 169, 209, 209)
        
      );

ThemeData DarkClassikMode = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Color.fromARGB(82, 30, 29, 49)
  ),
  shadowColor: Color.fromARGB(108, 37, 67, 77),
  indicatorColor: Color.fromARGB(106, 22, 80, 67),
  cardTheme: CardTheme(
    color: Color.fromRGBO(12, 13, 19, 0.71),
    surfaceTintColor: Colors.black87,
  ),

  textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white70), bodyMedium: TextStyle(color: Colors.white54)),

  iconTheme: IconThemeData(
    color: Colors.white38
  ),

  appBarTheme: const AppBarTheme(color:Color.fromARGB(255, 38, 51, 68),
  titleTextStyle: TextStyle(color: Colors.white60),
      centerTitle: true,
      shape:LinearBorder(),),

        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 33, 49, 70)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 17, 37, 43),
        dividerColor: const Color.fromARGB(164, 17, 1, 43)
  );
