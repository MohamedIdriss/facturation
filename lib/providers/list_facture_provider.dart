import 'package:flutter/cupertino.dart';

import 'package:projet_fin_etude/models/facture.dart';

class ListFactureProvider extends ChangeNotifier{
  List<Facture> _ListFacture =[];


  set listFacture(List<Facture> value) {
    _ListFacture = value;
    notifyListeners();
  }

  int existFacture(String id){
    int i=0;
    while(i <_ListFacture.length)
    {
      if(_ListFacture[i].id == id)
      {
        return i;

      }
      i++;



    }
    return -1;
  }


  List<Facture> get ListFacture => _ListFacture;

  Facture getitem(int index) => _ListFacture[index];

  void addItem(Facture item){
    _ListFacture.add(item);
    notifyListeners();

  }
  void updateItem(Facture item , int index){
    _ListFacture.removeAt(index);
    _ListFacture.insert(index, item);
    notifyListeners();

  }

  void deleteItem(int index){

    _ListFacture.removeAt(index);
    notifyListeners();

  }

}