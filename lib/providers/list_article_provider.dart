import 'package:flutter/cupertino.dart';
import 'package:projet_fin_etude/models/article.dart';

class ListArticleProvider extends ChangeNotifier{
  List<Article> listArt = [];

void addItem(Article item){

  listArt.add(item);
  notifyListeners();

}

int existArticle(String id){
  for(int i=0;i<listArt.length;i++)
  {
    if(listArt[i].id == id)
      {
        return i;

      }

  }
  return -1;
}




void updateItem(Article item , int index){
  listArt.removeAt(index);
  listArt.insert(index, item);
  notifyListeners();

}
Article getitem(int index) => listArt[index];

void deleteItem(int index){

  listArt.removeAt(index);
  notifyListeners();

}
List getList() => listArt;

void clearList(){

  listArt.clear();
  notifyListeners();

}


}