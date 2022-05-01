import 'package:flutter/material.dart';
import 'package:projet_fin_etude/providers/devis_provider.dart';
import 'package:projet_fin_etude/providers/remise_provider.dart';

import 'package:provider/src/provider.dart';


class RemisePage extends StatefulWidget {

  @override
  RemisePageState createState() => RemisePageState();

}

class RemisePageState extends State<RemisePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    final provDevis = Provider.of<DevisProvider>(context);
    final provRemise = Provider.of<RemiseProvider>(context);


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent[700],
          title: Text('Remise'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {


                if (_formKey.currentState!.validate() == true) {
                  _formKey.currentState!.save();
                  print(provDevis.typeremise);
                  provDevis.typeremise = provRemise.nomRemise;
                  print(provDevis.typeremise);
                  if(provDevis.typeremise == 'Aucune remise'){

                    provDevis.remise = 0 ;

                  }
                  else
                    {

                      if(provDevis.typeremise == 'Remise sur total'){

                        provDevis.poucentageRemise = provRemise.pourcentage;
                      }

                      else {
                        if(provDevis.typeremise == 'Montant fixe'){

                          provDevis.remise = provRemise.montantFixe;
                        }

                      }


                    }






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
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Remise:',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'DMSans',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            provRemise.nomRemise,
                            style: const TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'DMSans',
                              color: Colors.black,
                            ),
                          ),
                        ]),
                    onTap: () {
                      showModalBottomSheet<void>(
                        isDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                      title:  Center(
                                        child: Text(
                                          'Aucune remise',
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontFamily: 'DMSans',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      onTap: () {provRemise.setnomRemise('Aucune remise');
                                      provRemise.setisVisible(false);
                                      provRemise.setisVisible2(false);
                                      provRemise.setpourcentage(0);
                                      provRemise.setmontantFixe(0);
                                      Navigator.pop(context);
                                      }





                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                      title: const Center(
                                        child: Text(
                                          'Remise sur total',
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontFamily: 'DMSans',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        provRemise.setnomRemise('Remise sur total');
                                        provRemise.setisVisible(true);
                                        provRemise.setisVisible2(false);
                                        Navigator.pop(context);

                                      }
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                      title: const Center(
                                        child: Text(
                                          'Montant fixe',
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontFamily: 'DMSans',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      onTap: () {provRemise.setnomRemise('Montant fixe');
                                      Navigator.pop(context);
                                      provRemise.setisVisible(false);
                                      provRemise.setisVisible2(true);
                                      }
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
              ),
              Container(

                  child: Column(
                    children: [
                      Visibility(
                        child:Padding(padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(

                                label: Text('Remise sur total', style: TextStyle(color: Colors.black,
                                ),),

                                hintText: '0 %',
                              ),
                              //initialValue: widget.listRemise[1].toString(),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              initialValue:provRemise.pourcentage == 0 ? '' : provRemise.pourcentage.toString(),

                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Remise est requis';
                                }

                                return null;
                              },
                              onSaved: (String? value){
                                provRemise.setpourcentage(double.parse(value!));

                              },

                            )),
                        visible: provRemise.isVisible,
                      ),
                    ],
                  )
              ),
              Container(


                  child: Column(
                    children: [
                      Visibility(
                        child:Padding(padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: const InputDecoration(

                                label: Text('Montant fixe', style: TextStyle(color: Colors.black,
                                ),),

                                hintText: '0.0',
                              ),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              initialValue: provRemise.montantFixe == 0 ? '' : provRemise.montantFixe.toString(),


                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Remise est requis';
                                }

                                return null;
                              },
                              onSaved: (String? value){
                                provRemise.setmontantFixe(double.parse(value!));
                              },

                            )),
                        visible: provRemise.isVisible2,
                      ),
                    ],
                  )
              ),
            ],
          ),
        ));
  }



}
