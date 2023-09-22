import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk_to_gpt/presentation/pages/home_page.dart';
import 'package:talk_to_gpt/presentation/pages/onboarding_page.dart';

import '../../core/global_methods.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    showSplash(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
        body: Center(child: Image.asset('assets/icons/splash.png', color: Theme.of(context).iconTheme.color,)));
  }
}

Future<void> showSplash(context) async {
  Future.delayed(const Duration(milliseconds: 2500), () async {
    if(await isOnBoardOpened) {
      GlobalMethods.navigateReplace(
          context, HomePage());
    }else{
      GlobalMethods.navigateReplace(context, const OnBoardingPage());
    }
  });
}

Future<bool>  get isOnBoardOpened async {
  final prefs = await SharedPreferences.getInstance();
  final bool isOpened = prefs.getBool('opened') ?? false;

  return isOpened;

}
