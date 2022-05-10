import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';



class AppercuPDF extends StatefulWidget {
  String path='';
  AppercuPDF(this.path);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AppercuPDF> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(backgroundColor: Colors.deepPurpleAccent[700],
            title: Text('Appercu'),
            centerTitle: true,),
          body: Center(child: PDFView(
            filePath: widget.path,
          ),),);
  }
}