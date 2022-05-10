import 'package:flutter/cupertino.dart';

class RemiseProvider  extends ChangeNotifier{
  String _nomRemise='Aucune remise';
  double _pourcentage=0;
  double _montantFixe=0;
  bool _isVisible = false;
  bool _isVisible2 = false;


  RemiseProvider({nomRemise,pourcentage,montantFixe});


void initialRemiseProvider(){
  _nomRemise='Aucune remise';
  _pourcentage=0;
  _montantFixe=0;
  _isVisible = false;
  _isVisible2 = false;

  notifyListeners();

}


  bool get isVisible => _isVisible;

  void setisVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }



  String get nomRemise => _nomRemise;

  void setnomRemise(String value) {
    _nomRemise = value;
    notifyListeners();
  }

  double get pourcentage => _pourcentage;

  double get montantFixe => _montantFixe;

  void setmontantFixe(double value) {
    _montantFixe = value;
    notifyListeners();
  }

  void setpourcentage(double value) {
    _pourcentage = value;
    notifyListeners();
  }

  bool get isVisible2 => _isVisible2;

  void setisVisible2(bool value) {
    _isVisible2 = value;
    notifyListeners();
  }
}