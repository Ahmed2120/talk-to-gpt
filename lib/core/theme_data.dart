import 'package:flutter/material.dart';

class Styles {
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,


      scaffoldBackgroundColor:  const Color(0xFF202123),
      secondaryHeaderColor: const Color(0xFF343541),


      primaryColor: const Color(0xFF10A37F),

      cardColor: const Color(0xFFFFFFFF).withOpacity(0.2),
      canvasColor:const Color(0xFFFFFFFF).withOpacity(0.1),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: const ColorScheme.light()),

      dividerColor: const Color(0xFFFFFFFF).withOpacity(0.4),

      iconTheme: const IconThemeData(
          color: Colors.white
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold, color: Colors.white),
        titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 18.0, color: Colors.white),
        displaySmall: TextStyle(fontSize: 18.0, color: Color(0xFF202123), fontWeight: FontWeight.w700),
        bodyMedium: TextStyle(fontSize: 16.0, color: Colors.white),
        labelMedium: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );
  }


  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,


      scaffoldBackgroundColor:  Colors.white,
secondaryHeaderColor: Colors.white,

      primaryColor: const Color(0xFF10A37F),
      // colorScheme: ThemeData().colorScheme.copyWith(
      //   secondary: AppColors.primaryColor,
      //   brightness: Brightness.light,
      // ),

      cardColor: const Color(0xFF5D5E70),
      canvasColor:const Color(0xFF000000).withOpacity(0.3),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: const ColorScheme.light()),

      dividerColor: const Color(0xFF343541),

      iconTheme: const IconThemeData(
        color: Colors.black
      ),

      // fontFamily: 'Cairo',

      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold, color: Color(0xFF202123)),
        titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Color(0xFF202123)),
        bodyLarge: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w700),
        displaySmall: TextStyle(fontSize: 18.0, color: Color(0xFF202123), fontWeight: FontWeight.w700),
        bodyMedium: TextStyle(fontSize: 16.0, color: Color(0xFF202123)),
        labelMedium: TextStyle(fontSize: 16.0, color: Colors.white),

      ),
    );
  }
}
