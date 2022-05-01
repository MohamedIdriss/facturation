import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:projet_fin_etude/entreprise/take_logo.dart';
import 'package:projet_fin_etude/models/entreprise.dart';
import 'package:projet_fin_etude/providers/information_entreprise_provider.dart';

import 'package:provider/src/provider.dart';

class EntreprisePage extends StatefulWidget {

  @override
  EntreprisePageState createState() => EntreprisePageState();
}

class EntreprisePageState extends State<EntreprisePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  File? image;

  Future pickImage(ImageSource source) async {

    try{


      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image= imageTemporary;
      });


    } on PlatformException catch (e) {

      print('Failed to pick image :$e');
    }



  }

  Entreprise entreprise = new Entreprise();
  String nom='';
  String adresse='';
  int tel=0;
  String fax='';
  File? logo;
bool test=false;

  @override
  Widget build(BuildContext context) {
    var proventreprise=context.read<InformationEntrepriseprovider>() ;


    if(test == false)
      {
        image = proventreprise.logo;
        test =true;
      }







    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: Text('Entreprise'),
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

                proventreprise.setnom(entreprise.nom) ;
                proventreprise.setadresse(entreprise.adresse);
                proventreprise.settel(entreprise.tel);
                proventreprise.setfax(entreprise.fax);






                proventreprise.setlogo(image!);

                Navigator.pop(context );

    }



              print(proventreprise.logo);




              }
            ,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(

          children: [
            image!= null ?  Center(
              child: ClipOval(
                child: Image.file(image!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
            )  : Center(child: CameraPhoto()),
            SizedBox(height: 10,),
            Center(
              child: Text(
                "Logo de l'entreprise",
                style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 15.0,

                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30.0,),

            Center(
              child: MaterialButton(
                  height: 45,
                  minWidth: 150,
                  color: Colors.purple[600],
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  }, child: Text('Choisir une image',style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: 'DMSans'), )),
            ),
            SizedBox(height: 10,),
            Center(
              child: MaterialButton(
                  height: 45,
                  minWidth: 150,
                  color: Colors.purple[600],
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  }, child: Text('Prendre une photo',style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: 'DMSans'), )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Container(child: TextFormField(
                maxLengthEnforced: false,
                initialValue: context.watch<InformationEntrepriseprovider>().nom ,

                decoration: const InputDecoration(

                  hintText: "Nom d'entreprise",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Nom est requis';
                  }
                  else if (value.length>15) {
                    return 'Your text is too long !';
                  }
                  return null;
                },
                onSaved: (String? value){
                      entreprise.nom= value!;

                },

              )),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Container(child: TextFormField(
                maxLengthEnforced: false,
                initialValue: context.watch<InformationEntrepriseprovider>().adresse ,

                decoration: const InputDecoration(

                  hintText: "Adresse",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Adresse est requis';
                  }

                  return null;
                },
                onSaved: (String? value){
                entreprise.adresse =value!;

                },



              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Container(child: TextFormField(
                initialValue: context.watch<InformationEntrepriseprovider>().tel == 0 ? '' : context.watch<InformationEntrepriseprovider>().tel.toString(),

                decoration: const InputDecoration(

                  label: Text('Tel', style: TextStyle(color: Colors.black,
                  ),),


                ),
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number,

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Tel est requis';
                  }
                  else{
                    if(value.length != 8){
                      return 'saisie a valid numero';
                    }
                  }

                  return null;
                },
                onSaved: (String? value){
                  entreprise.tel=int.parse(value!);

                },

              )),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Container(child: TextFormField(
                initialValue: context.watch<InformationEntrepriseprovider>().fax == 0 ? '' : context.watch<InformationEntrepriseprovider>().fax.toString(),

                decoration: const InputDecoration(

                  label: Text('Fax', style: TextStyle(color: Colors.black,
                  ),),


                ),
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number,

             /*   validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Fax est requis';
                  }
                  else{
                    if(value.length != 8){
                      return 'saisie a valid numero';
                    }
                  }

                  return null;
                },*/
                onSaved: (String? value){
                  entreprise.fax = value!;

                },

              )),
            ),
            SizedBox(height: 500,)




          ],),
      ),
    );
  }
}




