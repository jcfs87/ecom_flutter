import 'package:ecom_app/screens/create_posts.dart';
import 'package:ecom_app/screens/home_screen.dart';
import 'package:ecom_app/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecom_app/providers/token.dart';
import 'package:ecom_app/register_login_screens/welcome_sign_in_screen.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({
    super.key,
  });

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  bool checkLoginStatus() {
    var tokenProvi = ref.watch(tokenProvider.notifier).state;
    return tokenProvi !=null;
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });

    if (_selectedPageIndex == 1 || _selectedPageIndex == 2) {
      // Check login status here
      bool isLoggedIn = checkLoginStatus(); // Implement this method

      if (!isLoggedIn) {
        // If not logged in, navigate to login screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeSignInScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();
    String activePageTitle = '';

    if (_selectedPageIndex == 1) {
      activePage = const CreatePosts();
    } else if (_selectedPageIndex == 2) {
      activePage = const PostsScreen();
      activePageTitle = 'Todas las publicaciones';
    }
    return Scaffold(
      appBar: AppBar(
      title: Text(activePageTitle),
      automaticallyImplyLeading: false,
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
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist_rtl), label: 'Publicaciones'),
        ],
      ),
    );
  }
}
