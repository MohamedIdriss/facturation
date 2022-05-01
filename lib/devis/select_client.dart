import 'package:flutter/material.dart';
import 'package:projet_fin_etude/providers/devis_provider.dart';
import 'package:projet_fin_etude/providers/list_client_provider.dart';
import 'package:projet_fin_etude/providers/list_devis_provider.dart';
import 'package:provider/src/provider.dart';

import 'ajout_client_page_devis.dart';



class Select_client extends StatefulWidget {



  @override
  _home_clientsState createState() => _home_clientsState();
}

class _home_clientsState extends State<Select_client> {


  @override
  Widget build(BuildContext context) {


    final provDevis = Provider.of<DevisProvider>(context);
    final provlistClient = Provider.of<ListClientProvider>(context);


    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: Text('Clients'),
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
              itemCount: provlistClient.listClient.length,
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

                        title: Text(provlistClient.listClient[index].nom,style: TextStyle(fontWeight: FontWeight.bold),),
                        //trailing: Text(articles[index].prix.toString(),style: TextStyle(fontSize: 15.0),),
                        onTap: (){
                          provDevis.client=provlistClient.listClient[index];
                          Navigator.pop(context);

                        }
                    ),
                  ),
                );
              },
            ),
          ),
          /* IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async{
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Ajout_article()),
              );
              if (result != null)
                {
                  setState(() {
                    articles.add(result);

                  });
                }

            },
          ),*/

        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Ajout_client_page_devis()),
          );


              Navigator.pop(context );



        },
        backgroundColor: Colors.deepPurpleAccent[700],
        child: const Icon(Icons.add),
      ),
    );
  }
}