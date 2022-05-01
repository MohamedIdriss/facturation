import 'dart:io';

import 'package:flutter/cupertino.dart';

class InformationEntrepriseprovider extends ChangeNotifier{

  String _nom='' ;
  String _adresse='';
  File? _logo  ;
  int _tel=0;
  String _fax='';


  String get fax => _fax;

  void setfax(String value) {
    _fax = value;
    notifyListeners();
  }

  int get tel => _tel;

  void settel(int value) {
    _tel = value;
    notifyListeners();
  }

  String get nom => _nom;

  void setnom(String value) {
    _nom = value;
    notifyListeners();
  }



  String get adresse => _adresse;

  void setadresse(String value) {
    _adresse = value;
    notifyListeners();
  }

  File? get logo => _logo;

  void setlogo(File value) {
    _logo = value;
    notifyListeners();
  }
}