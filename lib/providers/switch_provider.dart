import 'package:flutter/cupertino.dart';

class SwitchProvider extends ChangeNotifier{
  bool switchvalue = true;

  void changevalue(bool value){
    switchvalue = value;
    notifyListeners();

  }

}