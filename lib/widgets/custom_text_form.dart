import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm(
      {super.key,
      required this.hinText,
      required this.onSaved,
      required this.textValidator,
      required this.typeField,
      required this.oscuredText,
      this.prefixIcon});
  final String hinText;
  final void Function(String?)? onSaved;
  final String textValidator;
  final String typeField;
  final bool oscuredText;
  final Icon? prefixIcon;

  String? _validateField(String? value) {
    switch (typeField) {
      case 'email':
        return !EmailValidator.validate(value!, true)
            ? 'Not a valid email.'
            : null;
      case 'text':
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: const Color.fromARGB(77, 232, 228, 228),
      child: TextFormField(
        obscureText: oscuredText,
        decoration: InputDecoration(
          hintText: hinText,
          prefixIcon: prefixIcon,

          contentPadding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
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
          // fillColor: Colors.transparent,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        validator: (value) => _validateField(value),
        onSaved: onSaved,
      ),
    );
  }
}
