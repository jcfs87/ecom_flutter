import 'package:flutter/material.dart';

class User {
  const User({
     required this.name,
     required this.lastName,
     required this.address,
     required this.rol,
     required this.birthdate,
     required this.userType,
     required this.email,
     required this.password,
     required this.password_confirmation,
  });
  final String name;
  final String lastName;
  final String address;
  final String rol;
  final String birthdate;
  final String userType;
  final String email;
  final String password;
  final String password_confirmation;

   Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'address': address,
      'rol': rol,
      'birthdate': birthdate,
      'userType': userType,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
    };
  }

}