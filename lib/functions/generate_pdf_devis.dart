import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw ;
import 'package:pdf/widgets.dart';
import 'package:projet_fin_etude/entreprise/information_entreprise.dart';

import 'package:projet_fin_etude/models/devis.dart';
import 'package:projet_fin_etude/models/entreprise.dart';


class GeneratePdfDevis {


 static  pw.Document getdocument (Devis devis, Entreprise inforEntreprise, String numbancaccount) {




   final pdf = pw.Document();

   pdf.addPage(pw.MultiPage(
     build: (context) => [
       buildHeader(inforEntreprise, devis),
       pw.SizedBox(height: 3 * PdfPageFormat.cm),
       buildTitle(),
       buildInvoice(devis),
       pw.Divider(),

       //buildRow(devis),
      /* buitSignature(devis),*/
       buildTotal(devis),

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


 static Widget buildHeader(Entreprise inforEntreprise , Devis devis)  {



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
         buildCustomerAddress(devis),
         buildInvoiceInfo(devis),
       ],
     ),
   ],
 );}

 static Widget buildInvoice(Devis devis) {
   final headers = [
     'Description',
     'Quantité',
     'PU HT',
     'Total HTVA',
     'TVA',
     'Total TTC'
   ];
   final data = devis.listArticle.map((item) {
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

 static Widget buildRow(Devis devis){

   return SizedBox(child: Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,

     children: [
       buitSignature(devis),
       buildTotal(devis),

     ]



   ));
 }

 static Widget buitSignature(Devis devis){


   return Row(
     mainAxisAlignment: MainAxisAlignment.center,
       children:[

         Container(
     // alignment: Alignment.centerLeft,
     height: 70,
     width: 70,
     child: ClipOval(
       child: pw.Image(pw.MemoryImage(
           devis.signature
       ) ,

         fit: BoxFit.cover,
       ),
     ),
   )]);
 }


 static Widget buildTotal(Devis devis) {
   final totalhtva = devis.listArticle
       .map((item) => item.keys.first.prix * item.values.first)
       .reduce((item1, item2) => item1 + item2);
   final totaltva =  devis.listArticle
       .map((item) => ((item.keys.first.prix *(item.keys.first.poucentageTva /100)) * item.values.first))
       .reduce((item1, item2) => item1 + item2);



   final totalTTc = devis.total.toStringAsFixed(3);

   //final vatPercent = invoice.items.first.vat;
   /*final vat = netTotal * vatPercent;
   final total = netTotal + vat;*/

   return Container(
    // alignment: Alignment.centerRight,
     child: Row(
       children: [

        Expanded(child:  buitSignature(devis),),

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

 static Widget buildInvoiceInfo(Devis devis) {
   final paymentTerms = '${devis.validite.difference(devis.date).inDays} jours';
   final titles = <String>[
     'Numéro de Devis:',
     'Date de Devis:',
     'Modalités de paiement:',
     "Date d'échéance:"
   ];
   final data = <String>[
     devis.code.toString(),
     '${devis.date.day}-${devis.date.month}-${devis.date.year}',
     paymentTerms,
     '${devis.validite.day}-${devis.validite.month}-${devis.validite.year}',
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
       'Devis',
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


 static Widget buildCustomerAddress(Devis devis) => Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [
     Text(devis.client.nom, style: TextStyle(fontWeight: FontWeight.bold)),
     Text(devis.client.email)  ,
     Text(devis.client.tel),

   ],
 );



}
