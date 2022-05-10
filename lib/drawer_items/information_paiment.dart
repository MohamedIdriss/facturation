import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:projet_fin_etude/providers/information_paiment_provider.dart';

import 'package:provider/src/provider.dart';


class InformationPaiment extends StatefulWidget {

  @override
  InformationPaimentState createState() => InformationPaimentState();
}

class InformationPaimentState extends State<InformationPaiment> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String t='';

  @override
  Widget build(BuildContext context) {


    final numbankProvider = Provider.of<PaimentProvider>(context );


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: Text('Information de paiment'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()==true) {
                _formKey.currentState!.save();

              //  providerTva.setTva(t);
                numbankProvider.numBank= t;
                Navigator.pop(context);


              }
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Container(child: TextFormField(
                maxLengthEnforced: false,
                decoration: const InputDecoration(

                  hintText: 'RIB/RIP',
                ),


                initialValue: numbankProvider.numBank,
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'RIB/RIP est requis';
                  }
                  else if (value.length > 40) {
                    return 'RIB/RIP invalide !';
                  }
                  return null;
                },
                onSaved: (String? value){

                  t = value!;
                },

              )),
            ),





          ],),
      ),
    );
  }
}

Widget widgetTva(int t){
  return TextFormField(
    maxLengthEnforced: false,
    decoration: const InputDecoration(

      hintText: 'Description',
    ),
    keyboardType: TextInputType.number,
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'Tva est requis';
      }
      else if (int.parse(value)>99 && int.parse(value)< 0) {
        return 'Tva doit être dans 0 et 99 !';
      }
      return null;
    },
    onSaved: (String? value){

      t = int.parse(value!);
    },

  );
}
