import 'package:flutter/material.dart';
import 'package:projet_fin_etude/drawer_items/my_drawer.dart';
import 'package:projet_fin_etude/providers/list_article_provider.dart';
import 'package:provider/src/provider.dart';

import 'ajout_article.dart';
import 'modifier_article.dart';




class HomeArticles extends StatefulWidget {


  @override
  _Home_articlesState createState() => _Home_articlesState();
}

class _Home_articlesState extends State<HomeArticles> {

//List<Article> articles = [];a



  @override
  Widget build(BuildContext context) {
    final provlistArticle = Provider.of<ListArticleProvider>(context);

    return Scaffold(

      // backgroundColor: Colors.grey[400],
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: Text('Articles'),
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
            child:  provlistArticle.getList().isEmpty ? Container() : ListView.builder(
              itemCount: context.watch<ListArticleProvider>().getList().length,
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

                      title: Text(context.watch<ListArticleProvider>().getitem(index).description,style: TextStyle(fontWeight: FontWeight.bold),),
                     // subtitle: Text(context.watch<ListArticleProvider>().getitem(index).id),
                      trailing: Text(context.watch<ListArticleProvider>().getitem(index).prix.toString(),style: TextStyle(fontSize: 15.0),),
                      onTap: () async{
                         await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Modifier_article(context.watch<ListArticleProvider>().getitem(index).id), ),
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
           await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Ajout_article()),
          );


        },
        backgroundColor: Colors.deepPurpleAccent[700],
        child: const Icon(Icons.add),
      ),
    );
  }
}
