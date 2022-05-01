import 'package:flutter/material.dart';
import 'package:projet_fin_etude/devis/tab_bar_devis.dart';
import 'package:projet_fin_etude/drawer_items/my_drawer.dart';
import 'package:projet_fin_etude/models/devis.dart';

import 'package:projet_fin_etude/providers/devis_provider.dart';
import 'package:projet_fin_etude/providers/list_devis_provider.dart';

import 'package:provider/src/provider.dart';

import 'ajout_devis.dart';


class Home_devis extends StatefulWidget {




  @override
  _Home_devisState createState() => _Home_devisState();
}

class _Home_devisState extends State<Home_devis> {



  Devis dev =new Devis();


  @override
  Widget build(BuildContext context) {

    final provlistDevis = Provider.of<ListDevisProvider>(context);
    final provDevis = Provider.of<DevisProvider>(context);


    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: Text('Devis'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],

      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: provlistDevis.ListDevis.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 1.0,left: 1.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white,boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 3,

                      ),
                    ],),



                    child: ListTile(

                        title: Text(provlistDevis.ListDevis[index].code,style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text(provlistDevis.ListDevis[index].client.nom,style: TextStyle(fontSize: 15.0),),
                        trailing: Text(provlistDevis.ListDevis[index].total.toString(),style: TextStyle(fontSize: 15.0),),
                        onTap: ()async{
                          provDevis.initialDevisProvider();
                          provDevis.id=provlistDevis.ListDevis[index].id;
                          provDevis.code=provlistDevis.ListDevis[index].code;
                          provDevis.client=provlistDevis.ListDevis[index].client;

                          provDevis.remise=provlistDevis.ListDevis[index].remise;
                          provDevis.poucentageRemise=provlistDevis.ListDevis[index].poucentageRemise;
                          provDevis.typeremise=provlistDevis.ListDevis[index].typeremise;
                          provDevis.date=provlistDevis.ListDevis[index].date;
                          provDevis.total=provlistDevis.ListDevis[index].total;
                          provDevis.listArticle=provlistDevis.ListDevis[index].listArticle;

                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  TabBarDevis() ),
                        );


                      },
                    ),
                  ),
                );
              },
            ),
          ),


        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  TabBarDevis()),
          );
          provDevis.initialDevisProvider();


        },
        backgroundColor: Colors.deepPurpleAccent[700],
        child: const Icon(Icons.add),
      ),
    );
  }
}