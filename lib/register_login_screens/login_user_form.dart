import 'package:ecom_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/widgets/custom_text_form.dart';
import 'package:ecom_app/widgets/custom_password.dart';
import 'package:ecom_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginUserForm extends StatefulWidget {
  const LoginUserForm({super.key});

  @override
  State<LoginUserForm> createState() {
    return _LoginUserFormState();
  }
}


class _LoginUserFormState extends State<LoginUserForm> {
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';

  
void _loginUser() async {
  try{
     final navContext = context;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Login User');
      print(_email);
      print(_password);

      User user =  User.withEmailAndPassword(email: _email, password: _password);

      String jsonBody = json.encode(user.toJsonLogin());
      print('JSON enviado al servidor:');
      print(jsonBody);

       final url = Uri.parse('http://10.0.2.2:8000/api/login');
        final response = await http.post(
          url,
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonBody,
        );

        if (response.statusCode == 201) {
         Navigator.of(navContext).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const HomeScreen();
              },
            ),
          );
        } else {
          print(
              'Error al hacer login. Código de estado: ${response.statusCode}');
          print('Respuesta: ${response.body}');
          print('Sending request to: $url');
        }
    }
  } catch (e) {
    print('Error en la solicitud: $e');
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
                      GestureDetector(
                        onTap: () {
                          _loginUser();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'save',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
