
import 'dart:io';

import 'package:projet_fin_etude/devis/signature_preview_page.dart';
import 'package:projet_fin_etude/providers/facture_provider.dart';
import 'package:provider/src/provider.dart';
import 'package:projet_fin_etude/providers/devis_provider.dart';
import 'package:signature/signature.dart';
import 'package:flutter/material.dart';

class SignaturePagefacture extends StatefulWidget {
  const SignaturePagefacture({Key? key}) : super(key: key);

  @override
  _SignaturePagefactureState createState() => _SignaturePagefactureState();
}

class _SignaturePagefactureState extends State<SignaturePagefacture> {
  late SignatureController controller;

  @override
  void initState() {
    super.initState();

    controller = SignatureController(

      penStrokeWidth: 5,
      penColor: Colors.black,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final provFacture = Provider.of<FactureProvider>(context);








    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Signature(
              backgroundColor: Colors.white,
              controller: controller,
            ),
          ),

          Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async{
                    if(controller.isNotEmpty)
                    {
                      final signature = await exportSignature();



                      provFacture.signature = signature;


                      Navigator.pop(context);
                    }

                  },
                  icon: Icon(Icons.check),
                  color: Colors.green,
                ),


                IconButton(
                  onPressed: () {

                    Navigator.pop(context);
                  } ,
                  icon: Icon(Icons.clear),
                  color: Colors.red,
                )


              ],
            ),
          ),

        ],
      ),
    );
  }
/*
  Widget buildButtons(BuildContext context, File signature) => Container(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildCheck(context,signature),
            buildClear(),
          ],
        ),
      );

  Widget buildCheck(BuildContext context, File oldsignature) => IconButton(
        onPressed: () async{
          if(controller.isNotEmpty)
            {
              final signature = await exportSignature();


              Navigator.pop(context);
            }

        },
        icon: Icon(Icons.check),
        color: Colors.green,
      );

  Widget buildClear() => IconButton(
        onPressed: () {
          controller.clear();
          Navigator.pop(context);
        } ,
        icon: Icon(Icons.clear),
        color: Colors.red,
      );*/
  Future exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: controller.points,
    );

    final signature = await exportController.toPngBytes();


    exportController.dispose();



    return signature;

  }

}
