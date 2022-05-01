import 'package:flutter/material.dart';
import 'package:projet_fin_etude/providers/devis_provider.dart';
import 'package:projet_fin_etude/providers/list_article_provider.dart';
import 'package:provider/src/provider.dart';




class SelectArticle extends StatefulWidget {

  @override
  _SelectArticleState createState() => _SelectArticleState();
}

class _SelectArticleState extends State<SelectArticle> {



  @override
  Widget build(BuildContext context) {

    final provlistArticle = Provider.of<ListArticleProvider>(context);
    final provDevis = Provider.of<DevisProvider>(context);
    return Scaffold(

      // backgroundColor: Colors.grey[400],

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
            child: ListView.builder(
              itemCount: provlistArticle.listArt.length,
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

                      title: Text(provlistArticle.listArt[index].description,style: TextStyle(fontWeight: FontWeight.bold),),
                      trailing: Text(provlistArticle.listArt[index].prix.toString(),style: TextStyle(fontSize: 15.0),),
                      onTap: (){

                        Navigator.pop(context, provlistArticle.listArt[index].id);
                      }
                      /*async{
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Modifier_article(index,widget.articles), ),
                        );
                        if (result != null)
                        {
                          print(result);
                          setState(() {
                            widget.articles = result;

                          });
                        }

                      }*/,
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

    );
  }
}
