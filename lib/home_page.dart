import 'package:flutter/material.dart';
import 'package:projet_fin_etude/article/home_article.dart';

import 'client/home_client.dart';
import 'devis/home_devis.dart';
import 'facture/home_facture.dart';




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
      icon: ImageIcon(
      AssetImage("assets/invoice.png")
      )
    ),
    BottomNavigationBarItem(
      title: Text('Devis', style: TextStyle(
          fontFamily: 'DMSans')),
      icon: ImageIcon(
          AssetImage("assets/calculator.png")
      )
    ),
    BottomNavigationBarItem(
      title: Text('Clients',style: TextStyle(
          fontFamily: 'DMSans'),),
      icon: ImageIcon(
          AssetImage("assets/customer.png")
      )
    ),
    BottomNavigationBarItem(
      title: Text('Articles', style: TextStyle(
          fontFamily: 'DMSans')),
      icon: ImageIcon(
          AssetImage("assets/store.png")
      )
    ),
  ];


  Widget _currentWidget = Home_facture();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _currentWidget = Home_facture();

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
        iconSize: 27,
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