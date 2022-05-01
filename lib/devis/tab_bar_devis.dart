import 'package:flutter/material.dart';
import 'package:projet_fin_etude/devis/ajout_devis.dart';
import 'package:projet_fin_etude/devis/apercu_devis.dart';
import 'package:projet_fin_etude/models/devis.dart';
import 'package:projet_fin_etude/providers/devis_provider.dart';
import 'package:projet_fin_etude/providers/list_devis_provider.dart';
import 'package:provider/src/provider.dart';

class TabBarDevis extends StatelessWidget {
  const TabBarDevis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarDevisState();
  }
}

class TabBarDevisState extends StatefulWidget {
  const TabBarDevisState({Key? key}) : super(key: key);

  @override
  _TabBarDevisStateState createState() => _TabBarDevisStateState();
}

class _TabBarDevisStateState extends State<TabBarDevisState> {

  Devis devis = new Devis();
  @override
  Widget build(BuildContext context) {

    final provlistDevis = Provider.of<ListDevisProvider>(context);
    final provDevis = Provider.of<DevisProvider>(context);


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent[700],
          title: Text('Devis'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Modifier',),
              Tab(text: 'Apercu',)
            ],
          ),
          actions: <Widget>[
        IconButton(
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),
        onPressed: () {

          print(provDevis.id);
          if(provDevis.client.id!= '' || provDevis.listArticle.isNotEmpty)
          {
            devis.id = provDevis.id;
            devis.code= provDevis.code;
            devis.date= provDevis.date;
            devis.listArticle=provDevis.listArticle;
            devis.client= provDevis.client;
            devis.typeremise=provDevis.typeremise;
            devis.poucentageRemise=provDevis.poucentageRemise;
            devis.remise=provDevis.remise;
            devis.total=provDevis.total;
            print(devis.id);
            print(devis.code);
            print(devis.date);
            print(devis.listArticle);
            print(devis.client);
            print(devis.typeremise);
            print(devis.poucentageRemise);
            print(devis.remise);

            print(devis.total);


            print(provlistDevis.existDevis(devis.id));

            if(provlistDevis.existDevis(devis.id)!= -1)
              {
                provlistDevis.updateItem(devis, provlistDevis.existDevis(devis.id));
              }
            else
              {
                provlistDevis.addItem(devis);
              }

            provDevis.initialDevisProvider();

          }

          Navigator.pop(context );
        })],

        ),
        body: TabBarView(
          children: [
            AjoutDevis(),
            ApercuDevis()

          ],
        ),

      ),
    );
  }
}
/*
appBar: AppBar(
backgroundColor: Colors.deepPurpleAccent[700],
title: Text('Devis'),
centerTitle: true,
actions: <Widget>[
IconButton(
icon: Icon(
Icons.check,
color: Colors.white,
),
onPressed: () {

if(provDevis.client.id!= '' || provDevis.listArticle.isNotEmpty)
{
devis.id = provDevis.id;
devis.code= provDevis.code;
devis.date= provDevis.date;
devis.listArticle=provDevis.listArticle;
devis.client= provDevis.client;
devis.typeremise=provDevis.typeremise;
devis.poucentageRemise=provDevis.poucentageRemise;
devis.remise=provDevis.remise;
devis.tva=provDevis.tva;

provlistDevis.addItem(devis);

}

Navigator.pop(context );
},
)
],
),*/