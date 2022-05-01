import 'package:flutter/cupertino.dart';

class TvaProvider extends ChangeNotifier{
  int tva=19;

  int getTva() => tva;

  void setTva(int value) {
    tva=value;
    notifyListeners();
  }

}