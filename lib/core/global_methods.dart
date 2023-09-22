import 'package:flutter/material.dart';

class GlobalMethods{
  static void navigate(BuildContext context, Widget widget){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return widget;
        }));
  }

  static void navigateReplace(BuildContext context, Widget widget){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
          return widget;
        }));
  }

  static void navigateReplaceALL(BuildContext context, Widget widget){
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) {
          return widget;
        }),
            (route)=> false
    );
  }



  String formatTimeFromTime(TimeOfDay time){
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static bool rtlLang(String languageCode){
    RegExp rtlLanguages = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]+');

    if (rtlLanguages.hasMatch(languageCode[0])) {

      return true;
    } else {
      return false;
    }
  }

  static String showPrice(var price){
    if (price == 0){
      return 'مجاني';
    }
    return price.toString();

  }

}