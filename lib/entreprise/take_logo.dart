import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_fin_etude/providers/information_entreprise_provider.dart';
import 'dart:io';
import 'package:provider/src/provider.dart';
import '../home_page.dart';

class TakeLogo extends StatelessWidget {
  late TabController tabController;
  TakeLogo(this.tabController);


  @override
  Widget build(BuildContext context) {
    return TakeLogoState();
  }
}

class TakeLogoState extends StatefulWidget {
  const TakeLogoState({Key? key}) : super(key: key);

  @override
  _TakeLogoStateState createState() => _TakeLogoStateState();
}

class _TakeLogoStateState extends State<TakeLogoState> {

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

  @override
  Widget build(BuildContext context) {

    final providerentreprise = Provider.of<InformationEntrepriseprovider>(context );

    return Scaffold(


      body:Center(
        child: Column(


          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                MaterialButton(
                  minWidth: 150,
                   shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                    onPressed: () {

                      if(image != null)
                      {
                        providerentreprise.setlogo(image!);
                      }





                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  HomePage( )));





                      }
                    ,

                    child: const Text('Terminer')),
              ],
            ),
            SizedBox(height: 100.0,),
            Column(

              children: [
              image!= null ?  ClipOval(
                child: Image.file(image!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              )  : CameraPhoto(),
                SizedBox(height: 10,),
                Text(
                  "Logo de l'entreprise",
                  style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 15.0,

                      fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 30.0,),

                MaterialButton(
                    height: 45,
                    minWidth: 250,
                    color: Colors.purple[600],
    onPressed: () {
    pickImage(ImageSource.gallery);
    }, child: Text('Choisir une image',style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'DMSans'), )),
              SizedBox(height: 10,),
              MaterialButton(
                  height: 45,
                  minWidth: 250,
                  color: Colors.purple[600],
                  onPressed: () {
                pickImage(ImageSource.camera);
              }, child: Text('Prendre une photo',style: TextStyle(
    color: Colors.white,
    fontSize: 14.0,
    fontFamily: 'DMSans'), )),

            ],)

          ],
        ),
      ),
    );
  }
}
Widget CameraPhoto() {

  return CircleAvatar(
    radius: 90.0,
    backgroundImage: AssetImage('assets/camera_logo.png'),
  );
}

/*

* */