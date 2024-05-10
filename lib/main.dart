import 'package:ecom_app/register_login_screens/welcome_sign_in_screen.dart';
import 'package:ecom_app/screens/tap_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  // colorScheme: ColorScheme.fromSeed(
  //   brightness: Brightness.dark,
  //   seedColor: const Color.fromARGB(255, 131, 57, 0),
  // ),
  textTheme: GoogleFonts.latoTextTheme(),
);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const WelcomeSignInScreen(),
    );
  }
}
