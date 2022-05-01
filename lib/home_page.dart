import 'package:flutter/material.dart';
import 'package:projet_fin_etude/article/home_article.dart';

import 'client/home_client.dart';
import 'devis/home_devis.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;



  static const List<BottomNavigationBarItem> _navigationBarItems = [
    BottomNavigationBarItem(

      title: Text('Factures', style: TextStyle(
          fontFamily: 'DMSans')),
      icon: Icon(Icons.article),
    ),
    BottomNavigationBarItem(
      title: Text('Devis', style: TextStyle(
          fontFamily: 'DMSans')),
      icon: Icon(Icons.calculate),
    ),
    BottomNavigationBarItem(
      title: Text('Clients',style: TextStyle(
          fontFamily: 'DMSans'),),
      icon: Icon(Icons.account_circle),
    ),
    BottomNavigationBarItem(
      title: Text('Articles', style: TextStyle(
          fontFamily: 'DMSans')),
      icon: Icon(Icons.add_business),
    ),
  ];


  Widget _currentWidget = HomeArticles();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
         // _currentWidget = Home_Factures();

          break;
        case 1:
          _currentWidget = Home_devis();
          break;
        case 2:
          _currentWidget = Home_clients();
          break;
        case 3:
          _currentWidget = HomeArticles();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: _navigationBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent[700],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: _currentWidget,
    );
  }
}