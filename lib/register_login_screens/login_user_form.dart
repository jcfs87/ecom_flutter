import 'package:ecom_app/screens/tap_screen.dart';
import 'package:ecom_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/widgets/custom_text_form.dart';
import 'package:ecom_app/widgets/custom_password.dart';
import 'package:ecom_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecom_app/providers/token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginUserForm extends ConsumerStatefulWidget {
  const LoginUserForm({super.key});

  @override
  ConsumerState<LoginUserForm> createState() {
    return _LoginUserFormState();
  }
}

class _LoginUserFormState extends ConsumerState<LoginUserForm> {
  final _formKey = GlobalKey<FormState>();

  var _email = '';
  var _password = '';
  bool _isConnect = false;
  String? _error;

  void _loginUser() async {
    try {
      final navContext = context;
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        setState(() {
          _isConnect = true;
        });

        User user =
            User.withEmailAndPassword(email: _email, password: _password);

        String jsonBody = json.encode(user.toJsonLogin());

        final url = Uri.parse('http://10.0.2.2:8000/api/login');
        final response = await http
            .post(
              url,
              headers: {
                'Content-type': 'application/json',
              },
              body: jsonBody,
            )
            .timeout(const Duration(seconds: 10));

        if (response.statusCode >= 400) {
          setState(() {
            _error = 'Failed to fetch data. Please try again later';
          });
          return;
        } else {
          final responseData = json.decode(response.body);

          String tokenFromBack = responseData['token'];
         
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          await localStorage.setString('token', tokenFromBack);
          if (tokenFromBack.isNotEmpty) {
            ref.watch(tokenProvider.notifier).state = tokenFromBack;
          }
          
          Navigator.of(navContext).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const TabsScreen();
              },
            ),
          );
        }
      }
    } catch (error) {
      setState(() {
        // Si la excepción indica una falta de conexión con el servidor
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Haz login',
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
                      CustomTextForm(
                        hinText: 'Email address',
                        textValidator: 'Please enter email',
                        typeField: 'email',
                        oscuredText: false,
                        prefixIcon: const Icon(Icons.attach_email_outlined),
                        onSaved: (value) {
                          setState(() {
                            _email = value!;
                          });
                        },
                      ),
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
                        height: 300,
                      ),
                      ElevatedButton(
                        onPressed: _isConnect ? null : _loginUser,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            shadowColor: Colors.blueAccent,
                            minimumSize: const Size(120, 60)),
                        child: _isConnect
                            ? const SizedBox(
                                child: CircularProgressIndicator(),
                              )
                            : const Text(
                                'Login',
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
                                  color: const Color.fromARGB(249, 239, 5, 5),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                          ),
                        ),
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
