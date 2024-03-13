import 'package:flutter/material.dart';

class User {
  const User({
    required this.name,
    required this.lastName,
    required this.address,
    required this.birthdate,
    required this.email,
    required this.password,
    required this.password_confirmation,
  });
   const User.withEmailAndPassword({
    required this.email,
    required this.password,
  
  })  : password_confirmation = '',
        name = '',
        lastName = '',
        address = '',
        birthdate = '';
  final String name;
  final String lastName;
  final String address;
  final String birthdate;
  final String email;
  final String password;
  final String password_confirmation;

  Map<String, dynamic> toJsonRegister() {
    return {
      'name': name,
      'lastName': lastName,
      'address': address,
      'birthdate': birthdate,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
    };
  }

  Map<String, dynamic> toJsonLogin() {
     return {
      'email': email,
      'password': password,
     };
  }
}

class UserDummy extends User {
 final String imageUrl;

 UserDummy({
  required String name,
  required String imagen,
 })  : imageUrl = imagen,
       super(
        name: name,
        lastName: '',
        address: '',
        birthdate: '',
        email: '',
        password: '',
        password_confirmation: '',
       );
}
