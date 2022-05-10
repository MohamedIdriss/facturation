import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_fin_etude/devis/appercu_devis.dart';
import 'package:projet_fin_etude/functions/generate_pdf_facture.dart';
import 'package:projet_fin_etude/models/facture.dart';
import 'package:projet_fin_etude/providers/facture_provider.dart';
import 'package:projet_fin_etude/providers/list_facture_provider.dart';
import 'package:projet_fin_etude/providers/remise_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:projet_fin_etude/drawer_items/my_drawer.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:external_path/external_path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:projet_fin_etude/models/entreprise.dart';

import 'package:projet_fin_etude/providers/information_entreprise_provider.dart';
import 'package:projet_fin_etude/providers/information_paiment_provider.dart';


import 'package:provider/src/provider.dart';

import 'ajout_facture.dart';



class Home_facture extends StatefulWidget {
  @override
  _Home_factureState createState() => _Home_factureState();
}

class _Home_factureState extends State<Home_facture> {
  Facture dev = new Facture();
  Entreprise entreprise = new Entreprise();
  var uuid = Uuid();


  @override
  Widget build(BuildContext context) {
    final provlistFacture = Provider.of<ListFactureProvider>(context);
    final provFacture = Provider.of<FactureProvider>(context);
    final proventreprise = Provider.of<InformationEntrepriseprovider>(context);
    final provpaiment = Provider.of<PaimentProvider>(context);
    final provRemise = Provider.of<RemiseProvider>(context);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: Text('Facture'),
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
              itemCount: provlistFacture.ListFacture.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 1.0, left: 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        provlistFacture.ListFacture[index].code.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        provlistFacture.ListFacture[index].client.nom,
                        style: TextStyle(fontSize: 15.0),
                      ),
                      trailing: Text(
                        provlistFacture.ListFacture[index].total.toStringAsFixed(3),
                        style: TextStyle(fontSize: 15.0),
                      ),
                      onTap: () async {
                        provFacture.initialFactureProvider();
                        provFacture.id = provlistFacture.ListFacture[index].id;
                        provFacture.code = provlistFacture.ListFacture[index].code;
                        provFacture.client =
                            provlistFacture.ListFacture[index].client;

                        provFacture.remise =
                            provlistFacture.ListFacture[index].remise;
                        provFacture.poucentageRemise =
                            provlistFacture.ListFacture[index].poucentageRemise;
                        provFacture.typeremise =
                            provlistFacture.ListFacture[index].typeremise;
                        provFacture.date = provlistFacture.ListFacture[index].date;
                        provFacture.total = provlistFacture.ListFacture[index].total;
                        provFacture.listArticle =
                            provlistFacture.ListFacture[index].listArticle;

                        provFacture.signature =
                            provlistFacture.ListFacture[index].signature;
                        provFacture.signaturedate =
                            provlistFacture.ListFacture[index].signaturedate;

                        provRemise.initialRemiseProvider();


                        provRemise.setnomRemise(provlistFacture.ListFacture[index].typeremise);
                        provRemise.setpourcentage(provlistFacture.ListFacture[index].poucentageRemise);
                        provRemise.setmontantFixe(provlistFacture.ListFacture[index].remise);
                        if(provRemise.nomRemise == 'Aucune remise')
                        {
                          provRemise.setisVisible(false);
                          provRemise.setisVisible2(false);



                        }
                        else {

                          if(provRemise.nomRemise == 'Remise sur total'){

                            provRemise.setisVisible(true);
                            provRemise.setisVisible2(false);

                          }

                          else {

                            if(provRemise.nomRemise == 'Montant fixe'){

                              provRemise.setisVisible(false);
                              provRemise.setisVisible2(true);

                            }



                          }



                        }




                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AjoutFacture()),
                        );
                      },
                      onLongPress: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                    child: ListTile(
                                        title: const Center(
                                          child: Text(
                                            'Appercu',
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              fontFamily: 'DMSans',
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),


                                        /* pw.Page(
                                              pageFormat: PdfPageFormat.a4,
                                              build: (pw.Context context) {
                                                return pw.Center(
                                                  child: pw.Text(
                                                      "Hellodsfsdf World"),
                                                ); // Center
                                              }) */
                                        onTap: () async {

                                          entreprise.matriculefiscale = proventreprise.matriculefiscale;
                                          entreprise.logo= proventreprise.logo;
                                          entreprise.adresse=proventreprise.adresse;
                                          entreprise.tel=proventreprise.tel;
                                          entreprise.fax=proventreprise.fax;
                                          entreprise.nom=proventreprise.nom;


                                          /*  final ByteData bytes = await rootBundle.load(entreprise.logo!.path);
                                          final Uint8List byteList = bytes.buffer.asUint8List();*/

                                          final pdf = GeneratePdfFacture.getdocument(provlistFacture.ListFacture[index], entreprise,provpaiment.numBank );





                                          final output =
                                          await getTemporaryDirectory();
                                          final file = File(
                                              "${output.path}/example.pdf");
                                          // OpenFile.open("${output.path}/example.pdf");

                                          await file
                                              .writeAsBytes(await pdf.save());

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => AppercuPDF(
                                                    "${output.path}/example.pdf")),
                                          );
                                        }),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                        title: const Center(
                                          child: Text(
                                            'Supprimer',
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              fontFamily: 'DMSans',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: const Text(
                                                    'Souhaitez-vous vraiment supprimer cet Devis?',
                                                    style: TextStyle(
                                                        fontFamily: 'DMSans',
                                                        fontWeight: FontWeight.w100,
                                                        fontSize: 17.0),
                                                  ),
                                                  //content: const Text('AlertDialog description'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);

                                                        Navigator.pop(context);

                                                        provlistFacture
                                                            .deleteItem(index);
                                                      },
                                                      child:
                                                      const Text('SUPPRIMER'),
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
                                        }),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                        title: const Center(
                                          child: Text(
                                            'Duplique',
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              fontFamily: 'DMSans',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        onTap: () async {

                                          provFacture.initialFactureProvider();
                                          provFacture.id = uuid.v1();

                                          provFacture.code = DateTime.now().millisecondsSinceEpoch;
                                          provFacture.client =
                                              provlistFacture.ListFacture[index].client;

                                          provFacture.remise =
                                              provlistFacture.ListFacture[index].remise;
                                          provFacture.poucentageRemise =
                                              provlistFacture.ListFacture[index].poucentageRemise;
                                          provFacture.typeremise =
                                              provlistFacture.ListFacture[index].typeremise;
                                          provFacture.date = provlistFacture.ListFacture[index].date;
                                          provFacture.total = provlistFacture.ListFacture[index].total;
                                          provFacture.listArticle =
                                              provlistFacture.ListFacture[index].listArticle;
                                          provFacture.signature =
                                              provlistFacture.ListFacture[index].signature;
                                          provFacture.signaturedate =
                                              provlistFacture.ListFacture[index].signaturedate;

                                          provRemise.initialRemiseProvider();

                                          provRemise.setnomRemise(provlistFacture.ListFacture[index].typeremise);
                                          provRemise.setpourcentage(provlistFacture.ListFacture[index].poucentageRemise);
                                          provRemise.setmontantFixe(provlistFacture.ListFacture[index].remise);
                                          if(provRemise.nomRemise == 'Aucune remise')
                                          {
                                            provRemise.setisVisible(false);
                                            provRemise.setisVisible2(false);



                                          }
                                          else {

                                            if(provRemise.nomRemise == 'Remise sur total'){

                                              provRemise.setisVisible(true);
                                              provRemise.setisVisible2(false);

                                            }

                                            else {

                                              if(provRemise.nomRemise == 'Montant fixe'){

                                                provRemise.setisVisible(false);
                                                provRemise.setisVisible2(true);

                                              }



                                            }



                                          }


                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => AjoutFacture()),
                                          );




                                          Navigator.pop(context);
                                        }),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                        title: const Center(
                                          child: Text(
                                            'Email',
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              fontFamily: 'DMSans',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                        title: const Center(
                                          child: Text(
                                            'Télécharger',
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              fontFamily: 'DMSans',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        onTap: ()async {

                                          final pdf = GeneratePdfFacture.getdocument(provlistFacture.ListFacture[index], entreprise,provpaiment.numBank );
                                          var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);



                                          final file = File(
                                              "$path/facture_${provlistFacture.ListFacture[index].client.nom}.pdf");


                                          await file
                                              .writeAsBytes(await pdf.save());


                                          Navigator.pop(context);
                                          final scaffold = ScaffoldMessenger.of(context);

                                          scaffold.showSnackBar(
                                            SnackBar(
                                              content: const Text('Téléchargement terminer'),

                                            ),
                                          );




                                        }),
                                  ),

                                ],
                              ),
                            );
                          },
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
        onPressed: () async {
          provFacture.initialFactureProvider();
          provRemise.initialRemiseProvider();
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AjoutFacture()),
          );
        },
        backgroundColor: Colors.deepPurpleAccent[700],
        child: const Icon(Icons.add),
      ),
    );
  }
}
