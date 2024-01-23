import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecom_app/model/user.dart';
import 'package:intl/intl.dart';

class CreateUserForm extends StatefulWidget {
  const CreateUserForm({super.key});

  @override
  State<CreateUserForm> createState() {
    return _CreateUserFormState();
  }
}

class _CreateUserFormState extends State<CreateUserForm> {
  final _formKey = GlobalKey<FormState>();
  // String type
  var _name = '';
  // String type
  var _lastName = '';
  // String type
  var _address = '';
  // String type
  var _rol = '';
  //date type
  var _birthdate = '';
  //enum('user_type', ['provider', 'applicant']);
  var _userType = '';
  // String type
  var _email = '';
  //string y confirmationpassword
  var _password = '';
  var password_confirmation = '';

  void _saveUser() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        User user = User(
          name: _name,
          lastName: _lastName.trim(),
          address: _address,
          rol: _rol,
          birthdate: _birthdate,
          userType: _userType,
          email: _email,
          password: _password,
          password_confirmation: password_confirmation,
        );
        String jsonBody = json.encode(user.toJson());
        print('JSON enviado al servidor:');
        print(jsonBody);

        final url = Uri.parse('http://10.0.2.2:8000/api/register');
        final response = await http.post(
          url,
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonBody,
        );

        if (response.statusCode == 201) {
          print('Usuario creado exitosamente');
          print('URL: $url');
        } else {
          print(
              'Error al crear usuario. Código de estado: ${response.statusCode}');
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
      appBar: AppBar(
        title: const Text('Add a new user'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter name";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter last name";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _lastName = value!;
                      },
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Address',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter address";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _address = value!;
                      },
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Rol',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter rol";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _rol = value!;
                      },
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Birthdate',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter birthdate";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _birthdate = value!;
                      },
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter email";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'UserType',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter User Type";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userType = value!;
                      },
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password Confirmation',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password again";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password_confirmation = value!;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: _saveUser,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
