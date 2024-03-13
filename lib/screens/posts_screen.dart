import 'package:ecom_app/model/posts.dart';
import 'package:ecom_app/model/user.dart';
import 'package:ecom_app/widgets/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Posts> _postsItems = [];
  String? _error;
  var _isLoading = true;

  @override
  void initState() {
    _loadPosts();
    super.initState();
  }

void _loadPosts() async {
  final url = Uri.parse('http://10.0.2.2:8000/api/listPublicaciones');

  try {
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      setState(() {
        _error = 'No se pudo obtener los datos. Por favor, inténtalo de nuevo más tarde.';
      });
      return;
    }

    final listData = json.decode(response.body);
    print('Contenido de listData: $listData');
    
    List<Posts> loadedItems = [];
    for (var data in listData[0]) {
      loadedItems.add(
        Posts(
          pk_id_publicacion: data['pk_id_publicacion'],
          title: data['title'],
          description: data['description'],
          fk_user_id: data['fk_user_id'],
          type: data['type'],
          created_at: DateTime.parse(data['created_at']),
          updated_at: DateTime.parse(data['updated_at']),
        ),
      );
    }
    
    
    setState(() {
      _postsItems = loadedItems;
      _isLoading = false;
    });
    
   
  } catch (error) {
    setState(() {
      _error = 'Algo salió mal. Por favor, inténtalo de nuevo.';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Uh oh ... nothing here!'),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting a different category',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(),
          ),
        ],
      ),
    );

    if (_postsItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _postsItems.length,
        itemBuilder: (ctx, index) => PostsItem(posts: _postsItems[index]),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: content,
    );
  }
}
