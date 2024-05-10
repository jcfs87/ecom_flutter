import 'package:ecom_app/screens/create_posts.dart';
import 'package:ecom_app/screens/home_screen.dart';
import 'package:ecom_app/screens/posts_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, required this.token,});

  final String token;

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const PostsScreen();
    var activePageTitle = 'Posts';

    if (_selectedPageIndex == 1) {
      activePage =  CreatePosts(token: widget.token);
      activePageTitle = 'Create posts';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.control_point_rounded), label: 'Publicar'),
        ],
      ),
    );
  }
}
