import 'package:ecom_app/register_login_screens/second_personal_user_info.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/widgets/custom_text_form.dart';

class FirstPersonalUserInfo extends StatefulWidget {
  const FirstPersonalUserInfo({super.key});

  @override
  State<FirstPersonalUserInfo> createState() {
    return _FirstPersonalUserInfo();
  }
}

class _FirstPersonalUserInfo extends State<FirstPersonalUserInfo> {
  final _formKey = GlobalKey<FormState>();

  var _email = '';
  var _name = '';
  var _lastName = '';

  void _saveUser() {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        FocusScope.of(context).unfocus();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return SecondPersonalUserInfo(
                previousEmail: _email,
                previousName: _name,
                previousLastName: _lastName,
              );
            },
          ),
        );
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '¡Introduce tus datos!',
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
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextForm(
                            hinText: 'Name',
                            textValidator: 'Please enter name',
                            typeField: 'text',
                            oscuredText: false,
                            prefixIcon: const Icon(Icons.account_circle_outlined),
                            onSaved: (value) {
                              setState(() {
                                _name = value!;
                              });
                            }),
                        const SizedBox(height: 30),
                        CustomTextForm(
                          hinText: 'Last Name',
                          textValidator: 'Please enter Last name',
                          typeField: 'text',
                          oscuredText: false,
                          prefixIcon: const Icon(Icons.account_circle_outlined),
                          onSaved: (value) {
                            setState(() {
                              _lastName = value!;
                            });
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
        floatingActionButton: FloatingActionButton(
          onPressed: _saveUser,
          shape: const CircleBorder(),
          foregroundColor: Colors.white,
          backgroundColor: Colors.lightBlue,
          child: const Icon(Icons.arrow_forward),
        ));
  }
}
