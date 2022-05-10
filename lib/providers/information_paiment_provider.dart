

import 'package:flutter/cupertino.dart';

class PaimentProvider extends ChangeNotifier {
  String _numBank ='';

  String get numBank => _numBank;

  set numBank(String value) {
    _numBank = value;
    notifyListeners();
  }
}