import 'dart:io';


class Entreprise{
  String _nom='' ;
  String _adresse='';
  String _matriculefiscale = '';
  File? _logo  ;
  int _tel=0;
  String _fax='';

  String get matriculefiscale => _matriculefiscale;

  set matriculefiscale(String value) {
    _matriculefiscale = value;
  }


  String get nom => _nom;

  set nom(String value) {
    _nom = value;
  }

  String get adresse => _adresse;

  String get fax => _fax;

  set fax(String value) {
    _fax = value;
  }

  int get tel => _tel;

  set tel(int value) {
    _tel = value;
  }

  File? get logo => _logo;

  set logo(File? value) {
    _logo = value;
  }

  set adresse(String value) {
    _adresse = value;
  }
}