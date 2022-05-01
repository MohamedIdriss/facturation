import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_fin_etude/connextion.dart';
import 'package:projet_fin_etude/entreprise/take_logo.dart';
import 'package:projet_fin_etude/home_page.dart';
import 'package:projet_fin_etude/providers/devis_provider.dart';
import 'package:projet_fin_etude/providers/information_entreprise_provider.dart';
import 'package:projet_fin_etude/providers/list_article_provider.dart';
import 'package:projet_fin_etude/providers/list_client_provider.dart';
import 'package:projet_fin_etude/providers/list_devis_provider.dart';
import 'package:projet_fin_etude/providers/remise_provider.dart';
import 'package:projet_fin_etude/providers/switch_provider.dart';
import 'package:projet_fin_etude/providers/tva_provider.dart';
import 'package:projet_fin_etude/tabbar_logo_information.dart';

import 'package:provider/provider.dart';

import 'entreprise/information_entreprise.dart';





void main() {
  runApp(MultiProvider(
    providers: [/*ChangeNotifierProvider(create: (_) => Remise(),),*/
      ChangeNotifierProvider(create: (_) => InformationEntrepriseprovider()),
      ChangeNotifierProvider(create: (_) => ListArticleProvider()),
      ChangeNotifierProvider(create: (_) => ListClientProvider()),
      ChangeNotifierProvider(create: (_) => TvaProvider()),
      ChangeNotifierProvider(create: (_) => ListDevisProvider()),
      ChangeNotifierProvider(create: (_) => DevisProvider()),
      ChangeNotifierProvider(create: (_) => RemiseProvider()),

    ],
    child: MyApp(),
  ));

  /* SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.deepPurpleAccent[700]));*/
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter',
      home: HomePage(),
    );
  }
}
