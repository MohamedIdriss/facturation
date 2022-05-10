import 'package:flutter/material.dart';

import 'package:projet_fin_etude/models/article.dart';

import 'package:projet_fin_etude/providers/facture_provider.dart';
import 'package:projet_fin_etude/providers/list_article_provider.dart';
import 'package:provider/src/provider.dart';
import 'package:uuid/uuid.dart';

class ModifierArticleFacture extends StatefulWidget {
  String id='';

  ModifierArticleFacture(this.id);

  @override
  ModifierArticleFactureState createState() => ModifierArticleFactureState();
}

class ModifierArticleFactureState extends State<ModifierArticleFacture> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var uuid = Uuid();

  final DescriptionController = TextEditingController();
  final prixController = TextEditingController();
  final quantityController = TextEditingController();
  final pourcentageController =  TextEditingController();

  Article art = new Article();
  int quantite =1;

  bool test=false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    DescriptionController.dispose();
    prixController.dispose();
    quantityController.dispose();
    pourcentageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final provFacture = Provider.of<FactureProvider>(context);
    final provlistArticle = Provider.of<ListArticleProvider>(context);
    art.id = widget.id;


    if(test == false)
    {
      art.tva=provFacture.listArticle[provFacture.existArticleInFacture(widget.id)].keys.first.tva;
      DescriptionController.text= provFacture.listArticle[provFacture.existArticleInFacture(widget.id)].keys.first.description;
      prixController.text= provFacture.listArticle[provFacture.existArticleInFacture(widget.id)].keys.first.prix.toString();
      quantityController.text= provFacture.listArticle[provFacture.existArticleInFacture(widget.id)].values.first.toString();
      pourcentageController.text= provFacture.listArticle[provFacture.existArticleInFacture(widget.id)].keys.first.poucentageTva.toString();
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


                        provFacture.deleteArticleFromFacture(provFacture.existArticleInFacture(widget.id)) ;







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
              if (_formKey.currentState!.validate() == true) {
                _formKey.currentState!.save();


                provFacture.updateArticleInListArticle({art :  quantite}, provFacture.existArticleInFacture(art.id));
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
              child: Container(
                  child: TextFormField(
                    maxLengthEnforced: false,
                    controller: DescriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                    ),
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
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Container(
                  child: TextFormField(
                    controller: prixController,
                    decoration: InputDecoration(
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
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Container(child: TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(
                  label: Text(
                    'Quantité',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  hintText: '1',
                ),
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Quantité est requis';
                  }

                  return null;
                },
                onSaved: (String? value) {
                  quantite = int.parse(value!);
                },
              )),
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
                      test=true;
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
                  controller: pourcentageController,
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


/*

Widget widgetQuantite(ArticleDevis art) {
  return TextFormField(
    decoration: const InputDecoration(
      label: Text(
        'Quantité',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      hintText: '1',
    ),
    textAlign: TextAlign.start,
    keyboardType: TextInputType.number,
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'Quantité est requis';
      }

      return null;
    },
    onSaved: (String? value) {
      art.quantite = int.parse(value!);
    },
  );
}
*/