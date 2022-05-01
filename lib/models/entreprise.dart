class Entreprise{
  String _nom='' ;
  String _adresse='';
  String _logo ='' ;
  int _tel=0;
  String _fax='';




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

  String get logo => _logo;

  set logo(String value) {
    _logo = value;
  }

  set adresse(String value) {
    _adresse = value;
  }
}