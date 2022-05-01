import 'package:flutter/material.dart';
import 'package:projet_fin_etude/devis/select_article.dart';
import 'package:projet_fin_etude/models/article.dart';
import 'package:projet_fin_etude/models/devis.dart';
import 'package:projet_fin_etude/providers/devis_provider.dart';
import 'package:projet_fin_etude/providers/list_article_provider.dart';
import 'package:provider/src/provider.dart';
import 'package:uuid/uuid.dart';

class Ajout_article_devis extends StatefulWidget {


  @override
  Ajout_article_devisState createState() => Ajout_article_devisState();
}

class Ajout_article_devisState extends State<Ajout_article_devis> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var uuid = Uuid();

  final DescriptionController = TextEditingController();
  final prixController = TextEditingController();
  final pourcentageController =  TextEditingController();

  Article art = new Article();
  int quantite =1;
  bool switchValue = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    DescriptionController.dispose();
    prixController.dispose();
    pourcentageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final provDevis = Provider.of<DevisProvider>(context);
    final provlistArticle = Provider.of<ListArticleProvider>(context);

    if(art.id == ''){
      art.id = uuid.v1();

    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: Text('Article'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: ()  async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectArticle(),
                  ),
                );
                if (result != null) {
                  print(result);

                  setState(() {

                    DescriptionController.text = provlistArticle.listArt[provlistArticle.existArticle(result)].description;
                    prixController.text = provlistArticle.listArt[provlistArticle.existArticle(result)].prix.toString();
                    switchValue=provlistArticle.listArt[provlistArticle.existArticle(result)].tva;
                    art.id= result;
                    pourcentageController.text = provlistArticle.listArt[provlistArticle.existArticle(result)].poucentageTva.toString();
                  });
                }
              }),
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate() == true) {
                _formKey.currentState!.save();

                if(provDevis.existArticleInDivis(art.id)!=-1)

                  {
                    provDevis.updateArticleInListArticle({art : provDevis.listArticle[provDevis.existArticleInDivis(art.id)].values.first + quantite}, provDevis.existArticleInDivis(art.id));
                    provlistArticle.updateItem(art, provlistArticle.existArticle(art.id));

                  }
                else{
                  provDevis.addArticleToListArticle({art : quantite});
                  if(provlistArticle.existArticle(art.id)!=-1)
                    {
                      provlistArticle.updateItem(art, provlistArticle.existArticle(art.id));

                    }
                  else
                    {
                      provlistArticle.addItem(art);
                    }

                }


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
                  value: switchValue,
                  onChanged: (value) {
                    setState(() {
                      switchValue = value;
                      art.tva = switchValue;
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