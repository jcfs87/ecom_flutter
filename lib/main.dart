import 'package:ecom_app/register_login_screens/welcome_sign_in_screen.dart';
import 'package:ecom_app/screens/tap_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.latoTextTheme(),
  dividerTheme: const DividerThemeData(
    space: 50,
    color: Colors.grey
  )
);
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}
