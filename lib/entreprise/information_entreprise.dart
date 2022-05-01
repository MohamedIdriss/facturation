import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projet_fin_etude/providers/information_entreprise_provider.dart';
import 'package:provider/src/provider.dart';


class InformationEntreprise extends StatefulWidget {
late TabController tabController;

InformationEntreprise(this.tabController);
  @override
  _InformationEntrepriseState createState() => _InformationEntrepriseState();
}

class _InformationEntrepriseState extends State<InformationEntreprise> {
  TextEditingController nomController = new TextEditingController();
  TextEditingController adresseController = new TextEditingController();
  TextEditingController telelphoneController = new TextEditingController();
  TextEditingController faxController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final providerentreprise = Provider.of<InformationEntrepriseprovider>(context );
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Informations relatives à l’entreprise',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 80,
                  ),
                  Text('Nom de l’entreprise ',
                      style: TextStyle(
                          fontFamily: 'DMSans', fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nomController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),

                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.grey.shade200, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                   /* validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nom est requis';
                      }
                      return null;
                    },*/
                    onSaved: (String? value){
                      providerentreprise.setnom(value!) ;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Adresse",
                      style: TextStyle(
                          fontFamily: 'DMSans', fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: adresseController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.grey.shade200, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                   /* validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Adresse est requis';
                      }
                      return null;
                    },*/
                    onSaved: (String? value){
                      providerentreprise.setadresse(value!);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Téléphone",
                      style: TextStyle(
                          fontFamily: 'DMSans', fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: telelphoneController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.grey.shade200, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  /*  validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Téléphone est requis';
                      }
                      return null;
                    },*/
                    onSaved: (String? value){
                      providerentreprise.settel(int.parse(value!));
                    },
                  ),




                  Text("Fax",
                      style: TextStyle(
                          fontFamily: 'DMSans', fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    controller: faxController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.grey.shade200, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  /*  validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Fax est requis';
                      }
                      return null;
                    },*/
                    onSaved: (String? value){
                      providerentreprise.setfax(value!);
                    },
                  ),




                  SizedBox(
                    height: 40,
                  ),


                  Center(
                    child: MaterialButton(
                      onPressed: () {
                        //getproject();

                        if (_formKey.currentState!.validate()) {

                          widget.tabController.animateTo(1);
                        /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Inscription()));*/
                        }
                      },
                      height: 45,
                      color: Colors.purple[600],
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontFamily: 'DMSans'),
                      ),
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ));
  }
}
