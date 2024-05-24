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

  void _checkLoginAndNavigate() {
    if (_selectedPageIndex == 1 || _selectedPageIndex == 2) {
      if (!_checkLoginStatus()) {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const WelcomeSignInScreen()).then((_) {
          setState(() {
            _selectedPageIndex =
                0; // Redirigir a la pestaña de inicio si no está autenticado
          });
        });
      }
    }
  }

  bool _checkLoginStatus() {
    var tokenProvi = ref.watch(tokenProvider.notifier).state;
    return tokenProvi != null;
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    // _checkLoginAndNavigate();
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
        // automaticallyImplyLeading: false,
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
