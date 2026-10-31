import 'package:flutter/material.dart';
import 'package:serveyourself/helpers/routes.dart';
import 'package:serveyourself/pages/AddrecipePage.dart';
import 'package:serveyourself/pages/HistoriquePage.dart';

import 'package:serveyourself/pages/mealPage/meal_page_view.dart';
// import 'package:serveyourself/pages/HomePage.dart';

import '../components/navBar.dart';
import 'package:serveyourself/pages/favorisPage.dart';
import 'package:serveyourself/pages/ProfilPage.dart';


import 'homePage.dart';


class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Homepage(),
    Historiquepage(),
    FavoritesPage(),
    ProfilPage(),
  ];

  void _onNavigate(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onNavigate: _onNavigate,
        currentIndex: _selectedIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddrecipePage()),

          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
