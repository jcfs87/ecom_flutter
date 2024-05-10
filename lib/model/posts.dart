import 'package:flutter/material.dart';

class Posts {
  const Posts({
    required this.title,
    required this.description,
  });
  final String title;
  final String description;

  Map<String, dynamic> toJsonPosts() {
    return {
      'title': title,
      'description': description,
    };
  }
}
