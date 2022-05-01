import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:projet_fin_etude/models/devis_paper.dart';
import 'package:projet_fin_etude/pdfApi/pdf_api.dart';

class PdfDevisApi {


  static Future<File> generate(DevisPaper devis)async {

    var myTheme = ThemeData.withFont(
      base: Font.ttf(await rootBundle.load("fonts/DMSans-Regular.ttf")),

    );

    final pdf = Document(theme: myTheme);

    
    pdf.addPage(MultiPage(

      build: (context) => [

        buildTitle(devis),

      ]
    ));

    return PdfApi.saveDocument(name: 'my_devis.pdf', pdf: pdf);

  }

  static Widget buildTitle(DevisPaper devis) {



    return Column(crossAxisAlignment:
    CrossAxisAlignment.start,
        children : [
          Text(
            'DEVIS',
           // style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, ),
          ),

        ]);
  }

}