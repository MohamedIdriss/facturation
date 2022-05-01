import 'package:flutter/cupertino.dart';
import 'package:projet_fin_etude/models/client.dart';

class ListClientProvider extends ChangeNotifier{
  List<Client> _listClient = [];

  List<Client> get listClient => _listClient;



  int existClient(String id){
   int i=0;
      while(i <_listClient.length)
        {
          if(_listClient[i].id == id)
          {
            return i;

          }

          i++;


    }
    return -1;
  }
  void deleteitemid(String id)
  {

  }


  void setlistClient(List<Client> value) {
    _listClient = value;
  }

  Client getitem(int index) => _listClient[index];

  void addItem(Client client){
    _listClient.add(client);
    notifyListeners();

  }
  void updateItem(Client item , int index){
    _listClient.removeAt(index);
    _listClient.insert(index, item);
    notifyListeners();

  }

  void deleteItem(int index){

    _listClient.removeAt(index);
    notifyListeners();

  }

}