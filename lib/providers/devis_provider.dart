import 'package:flutter/cupertino.dart';
import 'package:projet_fin_etude/models/article.dart';
import 'package:projet_fin_etude/models/client.dart';


class DevisProvider  extends ChangeNotifier{
  String _id='';

  String _code='D00001';
  DateTime _date= DateTime.now();
  Client _client =  Client('','Client','','');
  List<Map<Article,int>> _listArticle = [];
  String _typeremise='Aucune remise';
  double _poucentageRemise =0;
  double _remise=0;
  double _total=0;


  double get poucentageRemise => _poucentageRemise;

  set poucentageRemise(double value) {
    _poucentageRemise = value;
  }



  String get typeremise => _typeremise;

  set typeremise(String value) {
    _typeremise = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  void initialDevisProvider(){
    _id='';
    _code='D00001';
    _date= DateTime.now();
    _client =  Client('','Client','','');
    _listArticle = [];
    _typeremise='Aucune remise';
    _poucentageRemise =0;
    _remise=0;
    _total=0;

    notifyListeners();
  }






  double get total => _total;

   set total(double value) {
    _total = value;
    notifyListeners();
  }



  double get remise => _remise;

   set remise(double value) {
    _remise = value;
    notifyListeners();
  }

  List<Map<Article,int>> get listArticle => _listArticle;

   set listArticle(List<Map<Article,int>> value) {
    _listArticle = value;
    notifyListeners();
  }

  Client get client => _client;

  set client(Client value) {
    _client = value;
    notifyListeners();
  }

  DateTime get date => _date;

   set date(DateTime value) {
    _date = value;
    notifyListeners();
  }

  String get code => _code;

   set code(String value) {
    _code = value;
    notifyListeners();
  }

  int existArticleInDivis(String id){

      for(int i=0;i<_listArticle.length;i++)
        {
          if(_listArticle[i].keys.first.id == id)
            {
              return i;

            }

        }
      return -1;


  }
  void addArticleToListArticle(Map<Article,int> value){
    _listArticle.add(value);
    notifyListeners();
  }
  void updateArticleInListArticle(Map<Article,int> value , int index){
    _listArticle.removeAt(index);
    _listArticle.insert(index, value);
    notifyListeners();

  }
  void deleteArticleFromDevis(int index){
     _listArticle.removeAt(index);
     notifyListeners();

  }

  double totalSansRemise(List<Map<Article,int>> listArticleDevis) {
    double res = 0;
    double montantTva=0;
    for (var i=0;i< listArticleDevis.length; i++) {

      if(listArticleDevis[i].keys.first.tva == true)
      {
        montantTva= (listArticleDevis[i].keys.first.poucentageTva /100)+1;
        res = res +((listArticleDevis[i].keys.first.prix * montantTva)* listArticleDevis[i].values.first);
      }
      else
      {
        res = res + (  listArticleDevis[i].keys.first.prix * listArticleDevis[i].values.first);
      }

    }

    return res;
  }
  double calcultotalAvecRemisePourcentage(double totalSansRemise, double pourcentage){

    double montantpoucentage =  totalSansRemise *(pourcentage /100) ;


    return totalSansRemise -montantpoucentage ;
  }

  double calcultotalAvecRemiseMontantFixe(double totalSansRemise, double montant)
  {
    return totalSansRemise - montant;

  }


  void setTotal(){
    _total =  calcultotal(totalSansRemise(_listArticle),_typeremise,_poucentageRemise,_remise);
    notifyListeners();


  }
  double calcultotal(double totalSansRemise, String typeRemise, double pourcentage, double montantfixe ){

    if(typeRemise=='Aucune remise')
    {

      return totalSansRemise;

    }
    else{
      if(typeRemise == 'Remise sur total')
      {

        return calcultotalAvecRemisePourcentage(totalSansRemise, pourcentage);
      }
      else
      {

        return calcultotalAvecRemiseMontantFixe(totalSansRemise, montantfixe);
      }

    }


  }


}