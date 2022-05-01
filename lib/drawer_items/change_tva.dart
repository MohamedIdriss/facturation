import 'package:flutter/material.dart';
import 'package:projet_fin_etude/models/article.dart';
import 'package:projet_fin_etude/providers/tva_provider.dart';
import 'package:provider/src/provider.dart';


class ChangeTva extends StatefulWidget {

  @override
  ChangeTvaState createState() => ChangeTvaState();
}

class ChangeTvaState extends State<ChangeTva> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

int t=0;

  @override
  Widget build(BuildContext context) {
    final providerTva = Provider.of<TvaProvider>(context );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: Text('TVA'),
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

            providerTva.setTva(t);
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

                  hintText: 'TVA',
                ),
                initialValue: providerTva.tva.toString(),
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'TVA est requis';
                  }
                  else if (int.parse(value)>99 || int.parse(value)< 0) {
                    return 'TVA doit être dans 0 et 99 !';
                  }
                  return null;
                },
                onSaved: (String? value){

                  t = int.parse(value!);
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
