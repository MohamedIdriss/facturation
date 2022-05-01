import 'package:flutter/material.dart';
import 'package:projet_fin_etude/providers/devis_provider.dart';
import 'package:projet_fin_etude/providers/list_client_provider.dart';
import 'package:provider/src/provider.dart';
import 'package:projet_fin_etude/models/client.dart';
import 'package:uuid/uuid.dart';

class Ajout_client_page_devis extends StatefulWidget {

  @override
  _Ajout_client_page_devisState createState() => _Ajout_client_page_devisState();
}

class _Ajout_client_page_devisState extends State<Ajout_client_page_devis> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Client client = new Client('','Client','','');
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    final provlistClient = Provider.of<ListClientProvider>(context);
    final provDevis = Provider.of<DevisProvider>(context);
    client.id=uuid.v1();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: Text('Client'),
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

provlistClient.addItem(client);
provDevis.client=client;
                Navigator.pop(context  );


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
              child: Container(child: widgetNom(client)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Container(child: widgetEmail(client)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Container(child: widgetMobile(client)),
            ),


            /* Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
        Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()==true) {
                      _formKey.currentState!.save();
                      Navigator.pop(context, art);


                    }
          },
          child: const Text('Valider')))]),*/
          ],
        ),
      ),
    );
  }
}

Widget widgetNom(Client client) {
  return TextFormField(
    decoration: const InputDecoration(
      hintText: 'Nom de client',
    ),
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'Nom est requis';
      } else if (value.length > 20) {
        return 'Votre texte est trop long !';
      }
      return null;
    },
    onSaved: (String? value) {
      client.setnom(value!);
    },
  );
}

Widget widgetEmail(Client client) {
  return TextFormField(
    maxLengthEnforced: false,
    decoration: const InputDecoration(
      hintText: 'Email',
    ),
    onSaved: (String? value) {
      if (value == null) {
        client.setemail('');
      } else {
        client.setemail(value);
      }
    },
  );
}

Widget widgetMobile(Client client) {
  return TextFormField(
    decoration: const InputDecoration(
      label: Text(
        'Mobile',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      hintText: 'Portable',
    ),

    textAlign: TextAlign.start,
    keyboardType: TextInputType.number,
    onSaved: (String? value) {
      if (value == null) {
        client.setTel('0');
      } else {
        client.setTel(value);
      }
    },
  );
}
/*
Widget widgetFax(Client client) {
  return TextFormField(
    decoration: const InputDecoration(
      label: Text(
        'Fax',
        style: TextStyle(
          color: Colors.black,
        ),
      ),

      hintText: 'Numéro de fax',
    ),

    textAlign: TextAlign.start,
    keyboardType: TextInputType.number,
    onSaved: (String? value) {
      if (value == null) {
        client.setfax('');
      } else {
        client.setfax(value);
      }
    },
  );
}
*/