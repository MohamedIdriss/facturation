import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw ;
import 'package:pdf/widgets.dart';

import 'package:projet_fin_etude/models/entreprise.dart';
import 'package:projet_fin_etude/models/facture.dart';


class GeneratePdfFacture {


  static  pw.Document getdocument (Facture facture, Entreprise inforEntreprise, String numbancaccount) {




    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        build: (context) => [
          buildHeader(inforEntreprise, facture),
          pw.SizedBox(height: 3 * PdfPageFormat.cm),
          buildTitle(),
          buildInvoice(facture),
          pw.Divider(),

          //buildRow(devis),
          /* buitSignature(devis),*/
          buildTotal(facture),

        ],
        footer: (context) {
          return Column(children: [
            Divider(),
            buildFooter(inforEntreprise,numbancaccount),

          ]);



        }
    ));





    return pdf;
  }

  static Widget buildFooter(Entreprise inforEntreprise, String numbancaccount) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [

      SizedBox(height: 1 * PdfPageFormat.mm),
      buildSimpleText(title: 'Matricule Fiscale', value: inforEntreprise.matriculefiscale),
      SizedBox(height: 1 * PdfPageFormat.mm),
      buildSimpleText(title: 'RIB', value: numbancaccount),
    ],
  );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      /* mainAxisSize: MainAxisSize.min,
     crossAxisAlignment: pw.CrossAxisAlignment.end,*/
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }


  static Widget buildHeader(Entreprise inforEntreprise , Facture facture)  {



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1 * PdfPageFormat.cm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSupplierAddress(inforEntreprise),
            Container(
              height: 50,
              width: 50,
              child: ClipOval(
                child: pw.Image(pw.MemoryImage(
                  File(inforEntreprise.logo!.path).readAsBytesSync(),
                ) ,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1 * PdfPageFormat.cm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCustomerAddress(facture),
            buildInvoiceInfo(facture),
          ],
        ),
      ],
    );}

  static Widget buildInvoice(Facture facture) {
    final headers = [
      'Description',
      'Quantité',
      'PU HT',
      'Total HTVA',
      'TVA',
      'Total TTC'
    ];
    final data = facture.listArticle.map((item) {
      final total = (item.keys.first.prix*((item.keys.first.poucentageTva /100)+1)) * item.values.first ;
      final totalhtva = item.keys.first.prix * item.values.first;

      return [
        item.keys.first.description,
        '${item.values.first}',
        '${item.keys.first.prix.toStringAsFixed(3)}',
        '${totalhtva.toStringAsFixed(3)}',
        '${item.keys.first.poucentageTva.toStringAsFixed(0)} %',
        '${total.toStringAsFixed(3)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildRow(Facture facture){

    return SizedBox(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          buitSignature(facture),
          buildTotal(facture),

        ]



    ));
  }

  static Widget buitSignature(Facture facture){


    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[

          Container(
            // alignment: Alignment.centerLeft,
            height: 70,
            width: 70,
            child: ClipOval(
              child: pw.Image(pw.MemoryImage(
                  facture.signature
              ) ,

                fit: BoxFit.cover,
              ),
            ),
          )]);
  }


  static Widget buildTotal(Facture facture) {
    final totalhtva = facture.listArticle
        .map((item) => item.keys.first.prix * item.values.first)
        .reduce((item1, item2) => item1 + item2);
    final totaltva =  facture.listArticle
        .map((item) => ((item.keys.first.prix *(item.keys.first.poucentageTva /100)) * item.values.first))
        .reduce((item1, item2) => item1 + item2);



    final totalTTc = facture.total.toStringAsFixed(3);

    //final vatPercent = invoice.items.first.vat;
    /*final vat = netTotal * vatPercent;
   final total = netTotal + vat;*/

    return Container(
      // alignment: Alignment.centerRight,
      child: Row(
        children: [

          Expanded(child:  buitSignature(facture),),

          // Spacer(flex: 1),
          Expanded(
            // flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Total H.TVA',
                  value: totalhtva.toStringAsFixed(3),
                  unite: true,
                ),
                buildText(
                  title: 'Total TVA',
                  value: totaltva.toStringAsFixed(3),
                  unite: true,
                ),

                // TODO: lazemni ne7seb remise wenzidha
                /*    buildText(
                 title: 'Remise',
                 value: devis..toStringAsFixed(3),
                 unite: true,
               ),*/
                Divider(),
                buildText(
                  title: 'Total TTC',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: totalTTc,
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildInvoiceInfo(Facture facture) {

    final titles = <String>[
      'Numéro de Facture:',
      'Date de Facture:',
    ];
    final data = <String>[
      facture.code.toString(),
      '${facture.date.day}-${facture.date.month}-${facture.date.year}',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildTitle() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Facture',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
      /*   Text(invoice.info.description),
     SizedBox(height: 0.8 * PdfPageFormat.cm),*/
    ],
  );

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  static Widget buildSupplierAddress(Entreprise inforEntreprise) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(inforEntreprise.nom, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text(inforEntreprise.adresse),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text('TEL: ${inforEntreprise.tel.toString()}'),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text('FAX: ${inforEntreprise.fax}'),
    ],
  );


  static Widget buildCustomerAddress(Facture facture) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(facture.client.nom, style: TextStyle(fontWeight: FontWeight.bold)),
      Text(facture.client.email)  ,
      Text(facture.client.tel),

    ],
  );



}
