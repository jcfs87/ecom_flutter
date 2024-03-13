import 'package:ecom_app/screens/home_screen.dart';
import 'package:ecom_app/screens/posts_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

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
      activePage = const HomeScreen();
      activePageTitle = 'Home';
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
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.image_search_rounded),
          //     label: 'Tus publicaciones'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.history_sharp), label: 'Mensajes'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.access_time_rounded), label: 'Perfil'),
        ],
      ),
    );
  }
}
