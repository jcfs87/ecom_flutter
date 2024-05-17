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
     this.token,
  });
  final String? token;
  @override
  State<CreatePosts> createState() {
    return _CreatePosts();
  }
}

class _CreatePosts extends State<CreatePosts> {
  final _formKey = GlobalKey<FormState>();

  var title = '';
  var description = '';
  String? _error;
  bool _isConnect = false;

  void _createPosts() async {
    // String _token = widget.token;
    try {
      final navContext = context;
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        setState(() {
          _isConnect = true;
        });

        Posts posts = Posts(
          title: title,
          description: description,
        );
        String jsonBody = json.encode(posts.toJsonPosts());

        final url = Uri.parse('http://10.0.2.2:8000/api/createPublicacion');
        final response = await http.post(
          url,
          headers: {
            'Content-type': 'application/json',
            // 'Authorization': 'Bearer $_token',
          },
          body: jsonBody,
        );
        if (response.statusCode == 201) {
          Navigator.of(navContext).push(
            MaterialPageRoute(
              builder: (context) {
                 return const TabsScreen();
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
    return SingleChildScrollView(
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
                      Material(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color.fromARGB(77, 232, 228, 228),
                        child: TextFormField(
                          minLines: 2,
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'description',
                            contentPadding:
                                const EdgeInsets.fromLTRB(30, 15, 30, 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 250, 250, 250),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length <= 10 ||
                                value.trim().length > 250) {
                              return 'Must be between 10 and 250 characters.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            description = value!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 300,
                      ),
                      ElevatedButton(
                        onPressed: _isConnect ? null : _createPosts,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            shadowColor: Colors.blueAccent,
                            minimumSize: const Size(120, 60)),
                        child: _isConnect
                            ? const SizedBox(
                                child: CircularProgressIndicator(),
                              )
                            : const Text(
                                'Create',
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
    );
  }
}
