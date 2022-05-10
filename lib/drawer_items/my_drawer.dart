import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projet_fin_etude/drawer_items/information_paiment.dart';
import 'package:projet_fin_etude/entreprise/take_logo.dart';
import 'package:projet_fin_etude/providers/information_entreprise_provider.dart';

import 'change_tva.dart';
import 'entreprise_page.dart';
import 'package:provider/src/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return myDrawerState();
  }
}

class myDrawerState extends StatefulWidget {
  const myDrawerState({Key? key}) : super(key: key);

  @override
  _myDrawerState createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawerState> {
  File? image;

  @override
  Widget build(BuildContext context) {
    var proventreprise = context.read<InformationEntrepriseprovider>();

    image = proventreprise.logo;

    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 300,
                child: DrawerHeader(
                 /* decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),*/
                  child: image != null
                      ? Center(
                          child: ClipOval(
                            child: Image.file(
                              image!,
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Center(child: CameraPhoto()),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Information entreprise',
                      style:  TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  /*  trailing: Icon(
                    Icons.settings,

                    color: Colors.black,
                  ),*/
                  onTap: () async {
                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EntreprisePage()));
                    setState(() {
                      image = proventreprise.logo;
                    });
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'Paiment',
                        style:  TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'DMSans',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    /*  trailing: Icon(
                  Icons.wrap_text,
                  color: Colors.black,
                ),*/
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InformationPaiment()));
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'Compte',
                        style:  TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'DMSans',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    /*   trailing: Icon(
                  Icons.settings,

                  color: Colors.black,
                ),*/
                    onTap: () {
                      /*
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage(cugmail: widget.currentgmail,pw: widget.password)
                  ));
*/
                    },
                  )),
            /*  SizedBox(
                height: MediaQuery.of(context).size.height / 11,
              ),*/
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: ListTile(
                  title: Center(
                    child: Text(
                    'Se déconnecter',
                      style:  TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
