import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:projet_fin_etude/models/devis.dart';
import 'package:projet_fin_etude/models/devis_paper.dart';
import 'package:projet_fin_etude/models/entreprise.dart';
import 'package:projet_fin_etude/pdfApi/pdf_api.dart';
import 'package:projet_fin_etude/pdfApi/pdf_devis_api.dart';
import 'package:projet_fin_etude/providers/devis_provider.dart';
import 'package:projet_fin_etude/providers/information_entreprise_provider.dart';
import 'package:provider/src/provider.dart';

class ApercuDevis extends StatelessWidget {
  const ApercuDevis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppercuDevisState();
  }
}

class AppercuDevisState extends StatefulWidget {
  const AppercuDevisState({Key? key}) : super(key: key);

  @override
  _AppercuDevisStateState createState() => _AppercuDevisStateState();
}

class _AppercuDevisStateState extends State<AppercuDevisState> {


  @override
  Widget build(BuildContext context) {

    final provDevis = Provider.of<DevisProvider>(context);
    var proventreprise=context.read<InformationEntrepriseprovider>() ;
    Devis dev = new Devis();
    dev.client=provDevis.client;
    dev.total=provDevis.total;
    dev.listArticle=provDevis.listArticle;
    dev.id= provDevis.id;
    dev.date=provDevis.date;
    dev.typeremise=provDevis.typeremise;
    dev.poucentageRemise=provDevis.poucentageRemise;
    dev.remise=provDevis.remise;
    dev.code=provDevis.code;

    Entreprise entreprise = new Entreprise();
    entreprise.nom=proventreprise.nom;
    entreprise.fax=proventreprise.fax;
    entreprise.tel=proventreprise.tel;
    entreprise.adresse=proventreprise.adresse;


    return Scaffold(

      body: Container(
        child: TextButton(child: Text('generate'),
        onPressed: ()async{

          final devisPaper = DevisPaper(
            client: provDevis.client,
            devis: dev,
            entreprise: entreprise
          );



          final pdfFile = await PdfDevisApi.generate(devisPaper);

          PdfApi.openFile(pdfFile);
        },),
      )

    );
  }
}

