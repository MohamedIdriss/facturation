import 'package:flutter/material.dart';

import 'entreprise/information_entreprise.dart';
import 'entreprise/take_logo.dart';



class HomeEntreprice extends StatelessWidget {
  const HomeEntreprice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeEntrepriceState();
  }
}

class HomeEntrepriceState extends StatefulWidget {
  const HomeEntrepriceState({Key? key}) : super(key: key);

  @override
  _HomeEntrepriceStateState createState() => _HomeEntrepriceStateState();
}

class _HomeEntrepriceStateState extends State<HomeEntrepriceState>  with SingleTickerProviderStateMixin{
  late TabController _tabController;


  @override
  void initState() {

    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: ReadOnlyTabBar(
        child: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.cloud_outlined),
            ),
            Tab(
              icon: Icon(Icons.beach_access_sharp),
            ),

          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          InformationEntreprise(_tabController),
          TakeLogo(_tabController),

        ],
      ),
    );
  }
}

class ReadOnlyTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabBar child;

  const ReadOnlyTabBar({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(child: child);
  }

  @override
  Size get preferredSize => child.preferredSize;
}
