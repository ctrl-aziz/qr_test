import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppPattern{
  //0xFF262626
  static Color mainColor = Colors.grey[300]!;
  // static Color mainColor = const Color(0xFF023535);
  // static Color secondaryColor = const Color(0xFFD9D9D9);
  static Color darkGreenColor = Colors.grey[300]!;
  static Color lightGreenColor = Colors.grey[200]!;
  static Color midGreenColor = Colors.grey[100]!;
  static Color? secondaryColor = Colors.white;
  // static Color? secondaryColor = const Color(0xFF0FC2C0);

  static ThemeData darkTheme = ThemeData(
    primarySwatch: createMaterialColor(midGreenColor),
    scaffoldBackgroundColor: mainColor,
    listTileTheme: ListTileThemeData(
      tileColor: mainColor,
      textColor: secondaryColor,
      iconColor: lightGreenColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: mainColor,
      foregroundColor: secondaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: mainColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      elevation: 0,
    ),
    iconTheme: IconThemeData(
      color: secondaryColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: mainColor,
      backgroundColor: secondaryColor,
    ),
    cardColor: secondaryColor,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: "Cairo",
        color: secondaryColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: darkGreenColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: lightGreenColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: darkGreenColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red),
      ),
      hoverColor: lightGreenColor.withOpacity(0.5),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(mainColor),
        backgroundColor: MaterialStateProperty.all(secondaryColor),
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    primarySwatch: createMaterialColor(midGreenColor),
    scaffoldBackgroundColor: secondaryColor,
    listTileTheme: ListTileThemeData(
      tileColor: mainColor,
      textColor: secondaryColor,
      iconColor: lightGreenColor,
    ),
    cardTheme: CardTheme(
      color: secondaryColor,
      shadowColor: lightGreenColor,
      surfaceTintColor: secondaryColor,
      elevation: 3
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: secondaryColor,
      foregroundColor: mainColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: secondaryColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      elevation: 0,
    ),
    iconTheme: IconThemeData(
      color: mainColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: secondaryColor,
      backgroundColor: mainColor,
    ),
    cardColor: mainColor,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: "Cairo",
        color: mainColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: darkGreenColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: lightGreenColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: darkGreenColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red),
      ),
      hoverColor: lightGreenColor.withOpacity(0.5),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(secondaryColor),
        backgroundColor: MaterialStateProperty.all(mainColor),
      ),
    ),
  );

  static double kPadding = 20.0;

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}