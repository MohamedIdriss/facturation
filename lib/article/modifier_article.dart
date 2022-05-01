

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/models/article.dart';
import 'package:projet_fin_etude/providers/list_article_provider.dart';
import 'package:projet_fin_etude/providers/switch_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/src/provider.dart';

class Modifier_article extends StatefulWidget {
   String id;

  Modifier_article(this.id);

  @override
  Modifier_articleState createState() => Modifier_articleState();
}

class Modifier_articleState extends State<Modifier_article> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Article art = new Article();
bool test=false;
int index=-1;


  @override
  Widget build(BuildContext context) {
    final provlistArticle = Provider.of<ListArticleProvider>(context);

art.id = widget.id;

      {

        if(test == false){

          art.tva= provlistArticle.getitem(provlistArticle.existArticle(widget.id)).tva;

        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent[700],
            title: Text('Article'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Souhaitez-vous vraiment supprimer cet article?',
                        style: TextStyle(
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.w100,
                            fontSize: 17.0),
                      ),
                      //content: const Text('AlertDialog description'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: (){

                            Navigator.pop(context);

                            Navigator.pop(context );



                            provlistArticle.deleteItem(provlistArticle.existArticle(widget.id));






                          }  ,
                          child: const Text('SUPPRIMER'),
                        ),
                        TextButton(
                          onPressed: () {

                            Navigator.pop(context);

                          },

                          child: const Text('ANNULER'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()==true) {
                    _formKey.currentState!.save();


                    provlistArticle.updateItem(art, provlistArticle.existArticle(widget.id));




                    Navigator.pop(context);


                  }
                },
              )
            ],
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: TextFormField(
                    maxLengthEnforced: false,
                    initialValue: provlistArticle.getitem(provlistArticle.existArticle(widget.id)).description,
                    decoration: const InputDecoration(hintText: 'description'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Description est requis';
                      } else if (value.length > 15) {
                        return 'Your text is too long !';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      art.description = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: TextFormField(
                    initialValue: provlistArticle.getitem(provlistArticle.existArticle(widget.id)).prix.toString(),
                    decoration: const InputDecoration(
                      label: Text(
                        'Prix unitaire',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      hintText: '0,00',
                    ),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Prix est requis';
                      }

                      return null;
                    },
                    onSaved: (String? value) {
                      art.prix = double.parse(value!);
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween
                      ,children:[
                    Text('TVA'),
                    Switch(
                      value: art.tva,
                      onChanged: (value) {
                        setState(() {
                          art.tva = value;
                          test= true;
                        });

                      },
                    ),

                  ]),
                ),

                Visibility(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Container(child: TextFormField(
                      decoration: const InputDecoration(

                        label: Text('Pourcentage TVA', style: TextStyle(color: Colors.black,
                        ),),

                        hintText: '0 %',
                      ),
                      initialValue: provlistArticle.listArt[provlistArticle.existArticle(widget.id)].poucentageTva.toString() == '0.0' ? '' :  provlistArticle.listArt[provlistArticle.existArticle(widget.id)].poucentageTva.toString(),
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,

                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'TVA est requis';
                        }

                        return null;
                      },
                      onSaved: (String? value){
                        art.poucentageTva = double.parse(value!);
                      },

                    )),
                  ),
                  visible: art.tva,
                ),


              ],
            ),
          ),
        );
      }


  }
}


