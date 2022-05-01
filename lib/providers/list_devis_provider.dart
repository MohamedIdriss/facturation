import 'package:flutter/cupertino.dart';
import 'package:projet_fin_etude/models/devis.dart';

class ListDevisProvider extends ChangeNotifier{
List<Devis> _ListDevis =[];


 set listDevis(List<Devis> value) {
  _ListDevis = value;
  notifyListeners();
}

int existDevis(String id){
  int i=0;
  while(i <_ListDevis.length)
  {
    if(_ListDevis[i].id == id)
    {
      return i;

    }
      i++;



  }
  return -1;
}


List<Devis> get ListDevis => _ListDevis;

  Devis getitem(int index) => _ListDevis[index];

void addItem(Devis item){
  _ListDevis.add(item);
  notifyListeners();

}
void updateItem(Devis item , int index){
  _ListDevis.removeAt(index);
  _ListDevis.insert(index, item);
  notifyListeners();

}

void deleteItem(int index){

  _ListDevis.removeAt(index);
  notifyListeners();

}

}