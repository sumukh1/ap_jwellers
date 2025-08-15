import 'package:flutter/material.dart';
import 'package:myapp/features/categories/presentation/pages/categories_page.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/egold/presentation/pages/egold_page.dart';
import 'package:myapp/features/gifts/presentation/pages/gifts_page.dart';
import 'package:myapp/features/you/presentation/pages/you_page.dart';
import 'package:myapp/features/home/presentation/widgets/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = "/HomePage";
  static String route() => routeName;
  static Widget builder(GoRouterState state) => const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeView(),
    CategoriesPage(),
    GiftsPage(),
    EGoldPage(),
    YouPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories',),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Gifts',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'E-Gold',),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'You',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}