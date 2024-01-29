import 'package:flutter/material.dart';


  void navigator(BuildContext context, Widget destination) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => destination ,
      ),
    );
  }