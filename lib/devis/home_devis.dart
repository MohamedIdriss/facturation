import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_fin_etude/devis/appercu_devis.dart';
import 'package:projet_fin_etude/providers/remise_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:projet_fin_etude/drawer_items/my_drawer.dart';
import 'package:projet_fin_etude/functions/generate_pdf_devis.dart';
import 'package:projet_fin_etude/models/devis.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:external_path/external_path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:projet_fin_etude/models/entreprise.dart';
import 'package:projet_fin_etude/providers/devis_provider.dart';
import 'package:projet_fin_etude/providers/information_entreprise_provider.dart';
import 'package:projet_fin_etude/providers/information_paiment_provider.dart';
import 'package:projet_fin_etude/providers/list_devis_provider.dart';

import 'package:provider/src/provider.dart';

import 'ajout_devis.dart';

class Home_devis extends StatefulWidget {
  @override
  _Home_devisState createState() => _Home_devisState();
}

class _Home_devisState extends State<Home_devis> {
  Devis dev = new Devis();
  Entreprise entreprise = new Entreprise();
  var uuid = Uuid();


  @override
  Widget build(BuildContext context) {
    final provlistDevis = Provider.of<ListDevisProvider>(context);
    final provDevis = Provider.of<DevisProvider>(context);
    final proventreprise = Provider.of<InformationEntrepriseprovider>(context);
    final provpaiment = Provider.of<PaimentProvider>(context);
    final provRemise = Provider.of<RemiseProvider>(context);

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: Text('Devis'),
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
              itemCount: provlistDevis.ListDevis.length,
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
                        provlistDevis.ListDevis[index].code.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        provlistDevis.ListDevis[index].client.nom,
                        style: TextStyle(fontSize: 15.0),
                      ),
                      trailing: Text(
                        provlistDevis.ListDevis[index].total.toStringAsFixed(3),
                        style: TextStyle(fontSize: 15.0),
                      ),
                      onTap: () async {
                        provDevis.initialDevisProvider();
                        provRemise.initialRemiseProvider();
                        provDevis.id = provlistDevis.ListDevis[index].id;
                        provDevis.code = provlistDevis.ListDevis[index].code;
                        provDevis.client =
                            provlistDevis.ListDevis[index].client;

                        provDevis.remise =
                            provlistDevis.ListDevis[index].remise;
                        provDevis.poucentageRemise =
                            provlistDevis.ListDevis[index].poucentageRemise;
                        provDevis.typeremise =
                            provlistDevis.ListDevis[index].typeremise;
                        provDevis.date = provlistDevis.ListDevis[index].date;
                        provDevis.total = provlistDevis.ListDevis[index].total;
                        provDevis.listArticle =
                            provlistDevis.ListDevis[index].listArticle;
                        provDevis.validite =
                            provlistDevis.ListDevis[index].validite;
                        provDevis.signature =
                            provlistDevis.ListDevis[index].signature;
                        provDevis.signaturedate =
                            provlistDevis.ListDevis[index].signaturedate;

                        provRemise.setnomRemise(provlistDevis.ListDevis[index].typeremise);
                        provRemise.setpourcentage(provlistDevis.ListDevis[index].poucentageRemise);
                        provRemise.setmontantFixe(provlistDevis.ListDevis[index].remise);
                        if(provRemise.nomRemise == 'Aucune remise')
                          {
                            provRemise.setisVisible(false);
                            provRemise.setisVisible(false);



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
                              builder: (context) => AjoutDevis()),
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

                                          final pdf = GeneratePdfDevis.getdocument(provlistDevis.ListDevis[index], entreprise,provpaiment.numBank );





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

                                                    provlistDevis
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

                                          provDevis.initialDevisProvider();
                                          provRemise.initialRemiseProvider();
                                          provDevis.id = uuid.v1();

                                          provDevis.code = DateTime.now().millisecondsSinceEpoch;
                                          provDevis.client =
                                              provlistDevis.ListDevis[index].client;

                                          provDevis.remise =
                                              provlistDevis.ListDevis[index].remise;
                                          provDevis.poucentageRemise =
                                              provlistDevis.ListDevis[index].poucentageRemise;
                                          provDevis.typeremise =
                                              provlistDevis.ListDevis[index].typeremise;
                                          provDevis.date = provlistDevis.ListDevis[index].date;
                                          provDevis.total = provlistDevis.ListDevis[index].total;
                                          provDevis.listArticle =
                                              provlistDevis.ListDevis[index].listArticle;
                                          provDevis.validite =
                                              provlistDevis.ListDevis[index].validite;
                                          provDevis.signature =
                                              provlistDevis.ListDevis[index].signature;
                                          provDevis.signaturedate =
                                              provlistDevis.ListDevis[index].signaturedate;

                                          provRemise.setnomRemise(provlistDevis.ListDevis[index].typeremise);
                                          provRemise.setpourcentage(provlistDevis.ListDevis[index].poucentageRemise);
                                          provRemise.setmontantFixe(provlistDevis.ListDevis[index].remise);
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
                                                builder: (context) => AjoutDevis()),
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

                                          final pdf = GeneratePdfDevis.getdocument(provlistDevis.ListDevis[index], entreprise,provpaiment.numBank );
                                          var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);



                                          final file = File(
                                              "$path/devis_${provlistDevis.ListDevis[index].client.nom}.pdf");


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
          provDevis.initialDevisProvider();
          provRemise.initialRemiseProvider();
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AjoutDevis()),
          );
        },
        backgroundColor: Colors.deepPurpleAccent[700],
        child: const Icon(Icons.add),
      ),
    );
  }
}
