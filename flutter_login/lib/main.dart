import 'package:flutter/material.dart';
import 'package:flutter_login/screens/home_screen.dart';
import 'package:flutter_login/screens/login_screen.dart';
import 'package:flutter_login/screens/splash_screen.dart';
import 'package:flutter_login/widgets/bottom_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn')?? false;
  runApp(MainApp(isLoggedIn: isLoggedIn,));
}

Future initialization(BuildContext? context) async{
  await Future.delayed(Duration(seconds: 3));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue).copyWith(
          surface: Colors.black,
          ),
        fontFamily: GoogleFonts.ptSans().fontFamily,
        useMaterial3: true,
        ),
        home:SplashScreen(),
        routes : {
        '/Bottom':(context) => const BottomNavBar(),
        '/home': (context) => const HomeScreen()
      },
    );
  }
}
