import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class CustomPassword extends StatefulWidget {
  const CustomPassword({
    super.key,
    required this.hintText,
    required this.onChanged,
     required this.validator,
  });
  final String hintText;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;


  @override
  State<CustomPassword> createState() {
    return _CustomPassword();
  }
}

class _CustomPassword extends State<CustomPassword> {
    bool _obscureText = true;
  @override
  
 Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: const Color.fromARGB(77, 232, 228, 228),
      child: TextFormField(
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
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
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        onChanged: widget.onChanged,
        validator: widget.validator,
      ),
    );
  }
}
