import 'package:flutter/material.dart';
import 'package:projet_fin_etude/providers/list_client_provider.dart';
import 'package:provider/src/provider.dart';
import 'package:projet_fin_etude/models/client.dart';



class Modifier_client extends StatefulWidget {
   String id;

  Modifier_client(this.id);

  @override
  Modifier_clientState createState() => Modifier_clientState();
}

class Modifier_clientState extends State<Modifier_client> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Client cli = new Client('','Client','','');

  @override
  Widget build(BuildContext context) {

    final provListClient = Provider.of<ListClientProvider>(context);
    cli.id= widget.id;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: Text('Client'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'Souhaitez-vous vraiment supprimer cet client?',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w100,
                        fontSize: 17.0),
                  ),
                  //content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: (){


                        provListClient.deleteItem(provListClient.existClient(widget.id));

                        Navigator.pop(context);

                        Navigator.pop(context);
                      }  ,
                      child: const Text('SUPPRIMER'),
                    ),
                    TextButton(
                      onPressed: () {

                        Navigator.pop(context);

                      },

                      child: const Text('ANNULER'),
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()==true) {
                _formKey.currentState!.save();


               provListClient.updateItem(cli, provListClient.existClient(widget.id));
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
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nom de client',
                ),
                initialValue: provListClient.listClient[provListClient.existClient(widget.id)].nom,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Nom est requis';
                  } else if (value.length > 20) {
                    return 'Votre texte est trop long !';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  cli.setnom(value!);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: TextFormField(
                maxLengthEnforced: false,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                initialValue: provListClient.listClient[provListClient.existClient(widget.id)].email,
                onSaved: (String? value) {
                  if (value == null) {
                    cli.setemail('');
                  } else {
                    cli.setemail(value);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    'Mobile',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Portable',
                ),
                initialValue: provListClient.listClient[provListClient.existClient(widget.id)].tel,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number,
                onSaved: (String? value) {
                  if (value == null) {
                    cli.setTel('');
                  } else {
                    cli.setTel(value);
                  }
                },
              ),
            ),


          ],
        ),
      ),
    );


  }


}
/*
Widget fax(Client cli){
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
    //initialValue: provListClient.listClient[widget.index].fax,
    textAlign: TextAlign.start,
    keyboardType: TextInputType.number,
    onSaved: (String? value) {
      if (value == null) {
        cli.setfax('');
      } else {
        cli.setfax(value);
      }
    },
  );
}
*/




