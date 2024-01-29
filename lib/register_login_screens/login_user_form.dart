
import 'package:flutter/material.dart';

class LoginUserForm extends StatefulWidget {
  const LoginUserForm({super.key});

  @override
  State<LoginUserForm> createState() {
   return _LoginUserFormState();
  }
}

class _LoginUserFormState extends State<LoginUserForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hacer login'),
      ),
    );
  }
}