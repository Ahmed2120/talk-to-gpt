import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:talk_to_gpt/controller/themeProvider.dart';
import 'controller/chatProvider.dart';
import 'core/theme_data.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/onboarding_page.dart';
import 'presentation/pages/splash_page.dart';

Future<void> main() async{
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> ThemeProvider()),
        ChangeNotifierProvider(create: (context)=> ChatProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            // darkTheme: Styles.darkTheme(context),
            // themeMode: themeProvider.darkTheme ? ThemeMode.dark : ThemeMode.light,
            theme: themeProvider.darkTheme ?  Styles.lightTheme(context) : Styles.darkTheme(context),
            home: const SplashPage(),
          );
        }
      ),
    );
  }
}

