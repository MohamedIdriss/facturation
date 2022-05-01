import 'package:flutter/material.dart';

import 'change_tva.dart';
import 'entreprise_page.dart';


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: SafeArea(
        child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
           /* CustomPaint(

              child: DrawerHeader(
                decoration:BoxDecoration(

                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [

                        Colors.blueAccent,
                        Colors.white,
                      ],
                    )
                ),

                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 55,
                      backgroundImage: NetworkImage("https://www.trustedclothes.com/blog/wp-content/uploads/2019/02/anonymous-person-221117.jpg"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    /*Text(
                      a.toString(),

                    ),*/
                    Text(''),

                  ],
                ),
              ),
            ),*/

            ListTile(
              title: Text(
                'Information entreprise',
                style: TextStyle(

                  fontSize: 16,
                  fontWeight: FontWeight.w500,

                ),

              ),
              trailing: Icon(
                Icons.settings,

                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EntreprisePage()
                    ));

              },
            ),
            ListTile(
              title: Text(
                'TVA',
                style: TextStyle(

                  fontSize: 16,
                  fontWeight: FontWeight.w500,

                ),

              ),
              trailing: Icon(
                Icons.wrap_text,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangeTva()
                    ));
              },
            ),


            ListTile(
              title: Text(
                'Compte',
                style: TextStyle(

                  fontSize: 16,
                  fontWeight: FontWeight.w500,

                ),

              ),
              trailing: Icon(
                Icons.settings,

                color: Colors.black,
              ),
              onTap: () {/*
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage(cugmail: widget.currentgmail,pw: widget.password)
                    ));
*/
              },
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: (){},/* => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()
                    )),*/
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Se déconnecter',

                      style: TextStyle(

                        fontSize: 16,
                        fontWeight: FontWeight.w500,

                      ),

                    ),
                    Icon(
                      Icons.settings_power,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}