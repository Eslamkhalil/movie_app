import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';



final Map<int, Color> yellow700Map = {
  50: const Color(0xFFFFD7C2),
  100: Colors.yellow[100]!,
  200: Colors.yellow[200]!,
  300: Colors.yellow[300]!,
  400: Colors.yellow[400]!,
  500: Colors.yellow[500]!,
  600: Colors.yellow[600]!,
  700: Colors.yellow[800]!,
  800: Colors.yellow[900]!,
  900: Colors.yellow[700]!,
};

final MaterialColor _yellow700Swatch =
    MaterialColor(Colors.yellow[500]!.value, yellow700Map);


ThemeData darkTheme = ThemeData(
  primarySwatch: _yellow700Swatch,
  scaffoldBackgroundColor: HexColor('333739'),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      fontFamily: 'muli',
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  /*bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: HexColor('333739'),
    ),*/
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white, ),
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.3,
    ),
    subtitle2: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.3,
    ),
  ),
  fontFamily: 'muli',
);





ThemeData lightTheme = ThemeData(
  primarySwatch: _yellow700Swatch,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black, ),
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color:Colors.black,
      height: 1.3,
    ),
    subtitle2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.white , height: 1.3,),

  ),
  fontFamily: 'muli',
);
