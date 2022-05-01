import 'package:flutter/material.dart';
import 'package:projet_fin_etude/client/ajout_client.dart';
import 'package:projet_fin_etude/drawer_items/my_drawer.dart';
import 'package:projet_fin_etude/providers/list_client_provider.dart';
import 'package:provider/src/provider.dart';

import 'modifier_client.dart';


class Home_clients extends StatefulWidget {



  @override
  _home_clientsState createState() => _home_clientsState();
}

class _home_clientsState extends State<Home_clients> {


  @override
  Widget build(BuildContext context) {

    final provListClient = Provider.of<ListClientProvider>(context);


    return Scaffold(
      drawer: MyDrawer(),
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
              itemCount: provListClient.listClient.length,
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

                      title: Text(provListClient.listClient[index].nom,style: TextStyle(fontWeight: FontWeight.bold),),
                     // subtitle: Text(provListClient.listClient[index].id),
                      //trailing: Text(articles[index].prix.toString(),style: TextStyle(fontSize: 15.0),),
                      onTap: ()
                      async{
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Modifier_client(provListClient.listClient[index].id), ),
                        );


                      },
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
            MaterialPageRoute(builder: (context) =>  AjoutClient()),
          );
        /*  if (result != null)
          {
            setState(() {
              widget.clients.add(result);

            });
          }*/

        },
        backgroundColor: Colors.deepPurpleAccent[700],
        child: const Icon(Icons.add),
      ),
    );
  }
}