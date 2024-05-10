import 'package:ecom_app/screens/home_screen.dart';
import 'package:ecom_app/screens/tap_screen.dart';
import 'package:ecom_app/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecom_app/model/posts.dart';

class CreatePosts extends StatefulWidget {
  const CreatePosts({
    super.key,
    required this.token,
  });
  final String token;
  @override
  State<CreatePosts> createState() {
    return _CreatePosts();
  }
}

class _CreatePosts extends State<CreatePosts> {
  final _formKey = GlobalKey<FormState>();

  var title = '';
  var description = '';

  void _createPosts(BuildContext context) async {
    String _token = widget.token;
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        Posts posts = Posts(
          title: title,
          description: description,
        );
        String jsonBody = json.encode(posts.toJsonPosts());
        print('JSON enviado al servidor:');
        print(jsonBody);

        final url = Uri.parse('http://10.0.2.2:8000/api/createPublicacion');
        final response = await http.post(
          url,
          headers: {
            'Content-type': 'application/json',
            'Authorization': 'Bearer $_token',
          },
          body: jsonBody,
        );
        if (response.statusCode == 201) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return TabsScreen(token: _token);
              },
            ),
          );
        } else {
          print(
              'Error al crear usuario. Código de estado: ${response.statusCode}');
          print('Respuesta: ${response.body}');
          print('Sending request to: $url');
        }
      }
    } catch (e) {
      print('Error en la solicitud $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    '¡Introduce datos!',
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
                        hinText: 'Title',
                        textValidator: 'Enter title',
                        typeField: 'text',
                        oscuredText: false,
                        prefixIcon: const Icon(Icons.abc),
                        onSaved: (value) {
                          setState(
                            () {
                              title = value!;
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextForm(
                        hinText: 'Description',
                        textValidator: 'Enter Description',
                        typeField: 'text',
                        oscuredText: false,
                        prefixIcon: const Icon(Icons.abc),
                        onSaved: (value) {
                          setState(
                            () {
                              description = value!;
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 300,
                      ),
                      CustomButton(
                        color: Colors.lightBlue,
                        text: 'Guardar',
                        onTapButton: () {
                          _createPosts(context);
                        },
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
