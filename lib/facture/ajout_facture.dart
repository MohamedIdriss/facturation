

import 'package:flutter/material.dart';

import 'package:projet_fin_etude/facture/remise_page_facture.dart';
import 'package:projet_fin_etude/facture/select_client_facture.dart';
import 'package:projet_fin_etude/facture/signature_preview_page_facture.dart';

import 'package:projet_fin_etude/models/client.dart';
import 'package:projet_fin_etude/models/facture.dart';

import 'package:projet_fin_etude/providers/facture_provider.dart';

import 'package:projet_fin_etude/providers/list_facture_provider.dart';

import 'package:provider/src/provider.dart';
import 'package:uuid/uuid.dart';

import 'ajout_article_facture.dart';
import 'modifier_article_page_facture.dart';




class AjoutFacture extends StatelessWidget {
  const AjoutFacture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ajout_facture_state();
  }
}


class Ajout_facture_state extends StatefulWidget {

  @override
  _Ajout_facture_stateState createState() => _Ajout_facture_stateState();
}

class _Ajout_facture_stateState extends State<Ajout_facture_state> {
  var numeroDevisText = RichText(
    text: TextSpan(
      style:  const TextStyle(
        fontSize: 17.0,
        fontFamily: 'DMSans',
        color: Colors.black,
      ),
      children: <TextSpan>[
        new TextSpan(text: 'Numéro de Facture '),
        /* new TextSpan(
            text: '*',
            style:
                new TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),*/
      ],
    ),
  );





  Facture facture = new Facture();


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




    }

  }





  @override
  Widget build(BuildContext context) {



    final provfacture = Provider.of<FactureProvider>(context);

   final provlistFacture = Provider.of<ListFactureProvider>(context);




    /* if(provDevis.listArticle.isNotEmpty)
      {
        provDevis.total= total(totalSansRemise(provDevis.listArticle, provTVA.tva), provDevis.typeremise, provDevis.poucentageRemise, provDevis.remise);

      }*/

    if(provfacture.id=='')
    {
      provfacture.id = uuid.v1();


    }








    if(provfacture.typeremise == 'Aucune remise'){

      remise =  '0 D';


    }
    else
    if(provfacture.typeremise == 'Remise sur total'){

      remise = provfacture.poucentageRemise.toString()+ ' %';
    }
    else
    if(provfacture.typeremise == 'Montant fixe'){

      remise = provfacture.remise.toString()+ ' D';
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

                print(provfacture.id);


                if(provfacture.client.id!= '' && provfacture.listArticle.isNotEmpty )
                {
                  facture.id = provfacture.id;
                  facture.code= provfacture.code;
                  facture.date= provfacture.date;
                  facture.listArticle=provfacture.listArticle;
                  facture.client= provfacture.client;
                  facture.typeremise=provfacture.typeremise;
                  facture.poucentageRemise=provfacture.poucentageRemise;
                  facture.remise=provfacture.remise;
                  facture.total=provfacture.total;
                  facture.signature=provfacture.signature;
                  facture.signaturedate=provfacture.signaturedate;




                  if(provlistFacture.existFacture(facture.id)!= -1)
                  {
                    provlistFacture.updateItem(facture, provlistFacture.existFacture(facture.id));
                  }
                  else
                  {
                    provlistFacture.addItem(facture);
                  }

                  provfacture.initialFactureProvider();
                  Navigator.pop(context );
                }
                else{

                  if(provfacture.client.id== ''){
                    _showToast(context, 0);

                  }
                  else{

                    if(provfacture.listArticle.isEmpty){
                      _showToast(context, 1);

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
                                provfacture.code.toString(),
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
                                '${provfacture.date.day}-${provfacture.date.month}-${provfacture.date.year}',
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              IconButton(
                                  onPressed: () async{

                                    final DateTime? selected = await showDatePicker(
                                      context: context,
                                      // locale:  Locale("fr", "FR"),
                                      initialDate: provfacture.date,
                                      firstDate: DateTime(2010),
                                      lastDate: DateTime(2025),
                                    );
                                    if (selected != null && selected != provfacture.date)
                                    {

                                      provfacture.date=selected;


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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            clientText(provfacture.client.nom),
                            IconButton(
                              iconSize: 20.0,
                              icon: const Icon(Icons.add),
                              onPressed: ()  async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Select_client_facture()),
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
                                                Ajout_article_facture()),
                                      );

                                      provfacture.setTotal();

                                    },
                                  ),
                                ]),
                            SizedBox(
                              height: sizedboxWidh * provfacture.listArticle.length,
                              child: Container(
                                /*  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),*/
                                child: ListView.builder(
                                  itemCount: provfacture.listArticle.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,

                                      ),
                                      child: ListTile(
                                        title: Text(
                                          provfacture.listArticle[index].keys.first.description,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        // subtitle: Text(provDevis.listArticle[index].keys.first.id),
                                        trailing: Text(
                                          '${provfacture.listArticle[index].values.first.toString()} * ${provfacture.listArticle[index].keys.first.prix.toStringAsFixed(3)}',
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                        onTap:
                                            ()  async{
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>  ModifierArticleFacture(provfacture.listArticle[index].keys.first.id), ),
                                          );

                                          provfacture.setTotal();

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
                                builder: (context) => RemisePageFacture(),
                              ),

                            );
                            setState(() {
                              remise= provfacture.typeremise;
                            });
                            provfacture.setTotal();
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
                                '${provfacture.total.toStringAsFixed(3)} D' ,
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
                    if(provfacture.signature.isEmpty){


                    }

                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  SignaturePreviewPageFacture(provfacture.signature)  ),
                    );



                  }, child: Text(
                provfacture.signature.isEmpty ? 'Signature' : 'Signé le ${provfacture.signaturedate.day}-${provfacture.signaturedate.month}-${provfacture.signaturedate.year}',
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