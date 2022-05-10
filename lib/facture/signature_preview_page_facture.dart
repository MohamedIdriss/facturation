import 'dart:typed_data';
import 'package:projet_fin_etude/devis/signature_page.dart';
import 'package:projet_fin_etude/facture/signature_page_facture.dart';
import 'package:projet_fin_etude/providers/facture_provider.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter/material.dart';
import 'package:projet_fin_etude/providers/devis_provider.dart';

class SignaturePreviewPageFacture extends StatefulWidget {
  final Uint8List signature;

  SignaturePreviewPageFacture(this.signature);

  @override
  _SignaturepreviexPageStateState createState() =>
      _SignaturepreviexPageStateState();
}

class _SignaturepreviexPageStateState extends State<SignaturePreviewPageFacture> {
  @override
  Widget build(BuildContext context) {
    final provFacture = Provider.of<FactureProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: Text('Signature'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              provFacture.signaturedate=DateTime.now();

              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Column(
        children: [
          provFacture.signature.isEmpty
              ? Center(
              child: Container(
                height: 400,
                width: 400,
                color: Colors.white,
              ))
              : Center(
            child: Container(
              color: Colors.white,
              height: 400.0,
              width: 400,
              // width: MediaQuery.of(context).size.width,
              child: Image.memory(

                provFacture.signature,

              ),
            ),
          ),
          Visibility(
            visible: provFacture.signature.isEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                  height: 45,
                  minWidth: 200,
                  color: Colors.deepPurpleAccent[700],
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignaturePagefacture()),
                    );
                  },
                  child: Text(
                    'Ajouter',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: 'DMSans'),
                  )),
            ),
          ),
          Visibility(
            visible: provFacture.signature.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                  height: 45,
                  minWidth: 200,
                  color: Colors.deepPurpleAccent[700],
                  onPressed: () {
                    provFacture.signature = Uint8List(0);
/*
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  SignaturePage()  ),
                      );*/
                  },
                  child: Text(
                    'Supprimer',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: 'DMSans'),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
