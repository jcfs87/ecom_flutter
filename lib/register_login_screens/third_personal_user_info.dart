import 'package:ecom_app/register_login_screens/login_user_form.dart';
import 'package:ecom_app/widgets/custom_button.dart';
import 'package:ecom_app/widgets/custom_password.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecom_app/model/user.dart';
import 'dart:convert';

class ThirdPersonalUserInfo extends StatefulWidget {
  const ThirdPersonalUserInfo({
    super.key,
    required this.previousEmail,
    required this.previousName,
    required this.previousLastName,
    required this.previusAddress,
    required this.previousBirthdate,
  });
  final String previousEmail;
  final String previousName;
  final String previousLastName;
  final String previousBirthdate;
  final String previusAddress;

  @override
  State<ThirdPersonalUserInfo> createState() {
    return _ThirdPersonalUserInfo();
  }
}

class _ThirdPersonalUserInfo extends State<ThirdPersonalUserInfo> {
  final _formKey = GlobalKey<FormState>();
  var _password = '';
  var _passwordConfirmation = '';
  String? _error;
   bool _isConnect = false;

  void _saveUser() async {
    try {
      final navContext = context;
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        setState(() {
          _isConnect = true;
        });

        User user = User(
          name: widget.previousName,
          lastName: widget.previousLastName,
          address: widget.previusAddress,
          birthdate: widget.previousBirthdate,
          email: widget.previousEmail,
          password: _password,
          password_confirmation: _passwordConfirmation,
        );
        String jsonBody = json.encode(user.toJsonRegister());

        final url = Uri.parse('http://10.0.2.2:8000/api/register');
        final response = await http
            .post(
              url,
              headers: {
                'Content-type': 'application/json',
              },
              body: jsonBody,
            )
            .timeout(const Duration(seconds: 10));

        if (response.statusCode == 201) {
          Navigator.of(navContext).push(
            MaterialPageRoute(
              builder: (context) {
                return const LoginUserForm();
              },
            ),
          );
        } else {
          setState(() {
            _error =
                'Error al crear usuario. Código de estado: ${response.statusCode}';
          });
        }
      }
    } catch (error) {
      setState(() {
        if (error is http.ClientException) {
          _error =
              'No connection to the server. Please check your internet connection and try again.';
          return;
        } else {
          _error = 'Something went wrong! Please try again later';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Introduce Contraseña',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      CustomPassword(
                        hintText: 'Password',
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please password is required';
                          } else if (value.trim().length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomPassword(
                        hintText: 'Password Confirmation',
                        onChanged: (value) {
                          setState(() {
                            _passwordConfirmation = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter confirmation Password";
                          } else if (value.length < 8) {
                            return "Password must be at least 8 characters long";
                          } else if (value.trim() != _password.trim()) {
                            return "Password must be same as above";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 300,
                      ),
                      ElevatedButton(
                        onPressed: _isConnect ? null : _saveUser,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            shadowColor: Colors.blueAccent,
                            minimumSize: const Size(120, 60)),
                        child: _isConnect
                            ? const SizedBox(
                                child: CircularProgressIndicator(),
                              )
                            : const Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                     if (_error != null)
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          _error!,
                          style: Theme.of(context)
                                 .textTheme
                                 .displaySmall!
                                 .copyWith(
                                  color: const Color.fromARGB(246, 239, 5, 5),
                                  fontWeight: FontWeight.normal,
                                  fontSize:12,
                                 )
                        )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
