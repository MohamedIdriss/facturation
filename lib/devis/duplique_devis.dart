import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/devis/signature_page.dart';
import 'package:projet_fin_etude/devis/signature_preview_page.dart';
import 'package:projet_fin_etude/devis/remise_page.dart';
import 'package:projet_fin_etude/devis/select_client.dart';
import 'package:projet_fin_etude/drawer_items/change_tva.dart';
import 'package:projet_fin_etude/models/article.dart';
import 'package:projet_fin_etude/models/client.dart';
import 'package:projet_fin_etude/models/devis.dart';
import 'package:projet_fin_etude/providers/devis_provider.dart';
import 'package:projet_fin_etude/providers/list_article_provider.dart';
import 'package:projet_fin_etude/providers/list_client_provider.dart';
import 'package:projet_fin_etude/providers/list_devis_provider.dart';
import 'package:projet_fin_etude/providers/tva_provider.dart';
import 'package:provider/src/provider.dart';
import 'package:uuid/uuid.dart';

import 'ajout_article_page_devis.dart';
import 'modifier_article_page_devis.dart';


class DupliqueDevis extends StatelessWidget {
  const DupliqueDevis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Duplique_devis_state();
  }
}


class Duplique_devis_state extends StatefulWidget {

  @override
  _Duplique_devis_stateState createState() => _Duplique_devis_stateState();
}

class _Duplique_devis_stateState extends State<Duplique_devis_state> {
  var numeroDevisText = RichText(
    text: TextSpan(
      style:  const TextStyle(
        fontSize: 17.0,
        fontFamily: 'DMSans',
        color: Colors.black,
      ),
      children: <TextSpan>[
        new TextSpan(text: 'Numéro de Devis '),
        /* new TextSpan(
            text: '*',
            style:
                new TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),*/
      ],
    ),
  );



  var validite = RichText(
    text: const TextSpan(
      style:  TextStyle(
        fontSize: 17.0,
        fontFamily: 'DMSans',
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(text: 'Validité '),
        TextSpan(
            text: '*',
            style:
            TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  Devis devis = new Devis();

  Client client =  new Client('','Client','','');
  var uuid = Uuid();



  var ajouterArticleText = RichText(
    text: new TextSpan(
      style: new TextStyle(
        fontSize: 17.0,
        fontFamily: 'DMSans',
        color: Colors.black,
      ),
      children: <TextSpan>[
        new TextSpan(text: 'Ajouter un Article '),
        new TextSpan(
            text: '*',
            style:
            new TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  DateTime selectedDate = DateTime.now();

  String date = "";
  double sizedboxWidh = 58.0 ;



  String remise='0 D';

  void _showToast(BuildContext context, int i) {
    final scaffold = ScaffoldMessenger.of(context);

    if(i==0)
    {
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Client est requis'),

        ),
      );

    }
    else {
      if(i==1)
      {
        scaffold.showSnackBar(
          SnackBar(
            content: const Text('Article est requis'),

          ),
        );

      }

      else {
        if(i==2)
        {
          scaffold.showSnackBar(
            SnackBar(
              content: const Text(' Date de validité est incorrecte'),

            ),
          );

        }


      }


    }

  }





  @override
  Widget build(BuildContext context) {
    final provDevis = Provider.of<DevisProvider>(context);
    final provTVA = Provider.of<TvaProvider>(context);

    final provlistDevis = Provider.of<ListDevisProvider>(context);
    final provlistClient = Provider.of<ListClientProvider>(context);
    final provlistArticle = Provider.of<ListArticleProvider>(context);


    /* if(provDevis.listArticle.isNotEmpty)
      {
        provDevis.total= total(totalSansRemise(provDevis.listArticle, provTVA.tva), provDevis.typeremise, provDevis.poucentageRemise, provDevis.remise);

      }*/

    if(provDevis.id=='')
    {
      provDevis.id = uuid.v1();


    }








    if(provDevis.typeremise == 'Aucune remise'){

      remise =  '0 D';


    }
    else
    if(provDevis.typeremise == 'Remise sur total'){

      remise = provDevis.poucentageRemise.toString()+ ' %';
    }
    else
    if(provDevis.typeremise == 'Montant fixe'){

      remise = provDevis.remise.toString()+ ' D';
    }




    return Scaffold(
      backgroundColor: Colors.grey[300],
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

                print(provDevis.id);


                if(provDevis.client.id!= '' && provDevis.listArticle.isNotEmpty && provDevis.validite.compareTo(provDevis.date) > 0)
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
                  devis.validite=provDevis.validite;
                  devis.signature=provDevis.signature;
                  devis.signaturedate=provDevis.signaturedate;




                  if(provlistDevis.existDevis(devis.id)!= -1)
                  {
                    provlistDevis.updateItem(devis, provlistDevis.existDevis(devis.id));
                  }
                  else
                  {
                    provlistDevis.addItem(devis);
                  }

                  provDevis.initialDevisProvider();
                  Navigator.pop(context );
                }
                else{

                  if(provDevis.client.id== ''){
                    _showToast(context, 0);

                  }
                  else{

                    if(provDevis.listArticle.isEmpty){
                      _showToast(context, 1);

                    }

                    else{

                      if(provDevis.validite.compareTo(provDevis.date) < 0 || provDevis.validite.compareTo(provDevis.date) == 0){
                        _showToast(context, 2);

                      }


                    }


                  }



                }


              })],

      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0,top: 16.0,right: 10.0,),
                      child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              numeroDevisText,
                              Text(
                                provDevis.code.toString(),
                                style: TextStyle(
                                    fontSize: 17.0, fontWeight: FontWeight.bold),
                              ),
                              /* IconButton(
                                iconSize: 20.0,
                                icon: const Icon(Icons.create_outlined),
                                onPressed: () async {


                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CodeDateDevis(devis)),
                                  );
                                  print(result.toString());
                                  if (result != null) {
                                    setState(() {
                                      devis.codeDevis = result[0];
                                      devis.date = result[1];
                                    });
                                  }
                                },
                              ),*/
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${provDevis.date.day}-${provDevis.date.month}-${provDevis.date.year}',
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              IconButton(
                                  onPressed: () async{

                                    final DateTime? selected = await showDatePicker(
                                      context: context,
                                      // locale:  Locale("fr", "FR"),
                                      initialDate: provDevis.date,
                                      firstDate: DateTime(2010),
                                      lastDate: DateTime(2025),
                                    );
                                    if (selected != null && selected != provDevis.date)
                                    {

                                      provDevis.date=selected;
                                      provDevis.validite=provDevis.date.add(Duration(days: 10));

                                    }



                                  },
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.deepPurpleAccent[700],
                                  ))
                            ])
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: [
                        validite,
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /* provDevis.validite.compareTo(provDevis.date) < 0 ? validite :*/ Text('${provDevis.validite.day}-${provDevis.validite.month}-${provDevis.validite.year}'),
                                IconButton(
                                    onPressed: () async{

                                      final DateTime? selected = await showDatePicker(
                                        context: context,
                                        // locale:  Locale("fr", "FR"),
                                        initialDate: provDevis.validite,
                                        firstDate: DateTime(2010),
                                        lastDate: DateTime(2025),
                                      );
                                      if (selected != null && selected != provDevis.validite )
                                      {

                                        provDevis.validite=selected;

                                      }



                                    },
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: Colors.deepPurpleAccent[700],
                                    ))
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            clientText(provDevis.client.nom),
                            IconButton(
                              iconSize: 20.0,
                              icon: const Icon(Icons.add),
                              onPressed: ()  async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Select_client()),
                                );

                              },
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(

                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ajouterArticleText,
                                  IconButton(

                                    iconSize: 20.0,
                                    icon: const Icon(Icons.add),
                                    onPressed: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Ajout_article_devis()),
                                      );

                                      provDevis.setTotal();

                                    },
                                  ),
                                ]),
                            SizedBox(
                              height: sizedboxWidh * provDevis.listArticle.length,
                              child: Container(
                                /*  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),*/
                                child: ListView.builder(
                                  itemCount: provDevis.listArticle.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,

                                      ),
                                      child: ListTile(
                                        title: Text(
                                          provDevis.listArticle[index].keys.first.description,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        // subtitle: Text(provDevis.listArticle[index].keys.first.id),
                                        trailing: Text(
                                          '${provDevis.listArticle[index].values.first.toString()} * ${provDevis.listArticle[index].keys.first.prix.toStringAsFixed(3)}',
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                        onTap:
                                            ()  async{
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>  ModifierArticleDevis(provDevis.listArticle[index].keys.first.id), ),
                                          );

                                          provDevis.setTotal();

                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: Column(children: [
                        GestureDetector(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Remise',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: 'DMSans',
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  remise,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ]),
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RemisePage(),
                              ),

                            );
                            setState(() {
                              remise= provDevis.typeremise;
                            });
                            provDevis.setTotal();
                          },
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: 'DMSans',
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${provDevis.total.toStringAsFixed(3)} D' ,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                        /* GestureDetector(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'TVA',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: 'DMSans',
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '${provTVA.tva} %',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ]),
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeTva(),
                              ),

                            );
                            print(provDevis.typeremise);
                          },
                        ),*/

                        /* Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total H. remise',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: 'DMSans',
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${totalSansRemise(provDevis.listArticle, provTVA.tva)} D',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                ),
                              ),
                            ])*/

                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: MaterialButton(
                  height: 45,
                  minWidth: 400,
                  color: Colors.deepPurpleAccent[700],
                  onPressed: ()async{
                    if(provDevis.signature.isEmpty){


                    }

                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  SignaturePreviewPage(provDevis.signature)  ),
                    );



                  }, child: Text(
                provDevis.signature.isEmpty ? 'Signature' : 'Signé le ${provDevis.signaturedate.day}-${provDevis.signaturedate.month}-${provDevis.signaturedate.year}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'DMSans'), )),
            ),
            SizedBox(height: 200.0,)
          ],
        ),
      ),
    );
  }

}

Widget clientText(String a) {
  if (a == 'Client') {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 17.0,
          fontFamily: 'DMSans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: 'À '),
          TextSpan(text: '*', style: TextStyle(color: Colors.red)),
          TextSpan(text: ' : '),
          TextSpan(text: a, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  } else {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 17.0,
          fontFamily: 'DMSans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: 'À '),
          TextSpan(text: '*', style: TextStyle(color: Colors.red)),
          TextSpan(text: ' : '),
          TextSpan(text: a, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
/*
'${total(totalSansRemise(provDevis.listArticle, provTVA.tva), provDevis.typeremise, provDevis.poucentageRemise, provDevis.remise)} D',
*/