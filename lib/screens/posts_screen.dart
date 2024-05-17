import 'package:ecom_app/model/posts_with_user_puntos.dart';

import 'package:ecom_app/widgets/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostsScreen extends StatefulWidget {
  const PostsScreen({
    super.key,
    this.title,
  });

  final String? title;

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<PostsWithUserAndTotalRating> _postsItems = [];
  String? _error;
  var _isLoading = true;

  @override
  void initState() {
    _loadPosts();
    super.initState();
  }

  void _loadPosts() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/publicacionesWithUser');

    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error =
              'No se pudo obtener los datos. Por favor, inténtalo de nuevo más tarde.';
        });
      }
      final listData = json.decode(response.body);
      print(response.body);

      List<PostsWithUserAndTotalRating> loadedItems = [];
      for (var data in listData) {
        loadedItems.add(
          PostsWithUserAndTotalRating(
              title: data['title'],
              total_puntos: data['total_puntos'],
              description: data['description'],
              name: data['name'],
              photo: data['photo'],
              created_at: data['created_at']),
        );
      }
      setState(() {
        _postsItems = loadedItems;
        _isLoading = false;
        _error = null;
      });
    } catch (error) {
      setState(() {
        _error = 'SomeThing went wrong! Please try again later';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('Not items added yet!'),
    );
    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }
    if (_postsItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _postsItems.length,
        itemBuilder: (ctx, index) => PostsItem(posts: _postsItems[index]),
      );
    }
    if (_error != null) {
      content = Center(child: Text(_error!));
    }
    
    
    return content;
  }
}
