
import 'package:projet_fin_etude/models/article.dart';

import 'client.dart';

class Devis {
  String _id='';
  String _code='D00001';
  DateTime _date=DateTime.now();
  Client _client = new Client('','Client','','');
  List<Map<Article,int>> _listArticle = [];
  String _typeremise='Aucune remise';
  double _poucentageRemise =0;
  double _remise=0;
  double _total=0;





  String get id => _id;

  set id(String value) {
    _id = value;
  }





  String get typeremise => _typeremise;

  set typeremise(String value) {
    _typeremise = value;
  }




  double get total => _total;

   set total(double value) {
    _total = value;
  }

  double get remise => _remise;

   set remise(double value) {
    _remise = value;
  }

  List<Map<Article,int>> get listArticle => _listArticle;

   set listArticle(List<Map<Article,int>> value) {
    _listArticle = value;
  }

  Client get client => _client;

  set client(Client value) {
    _client = value;
  }

  DateTime get date => _date;

   set date(DateTime value) {
    _date = value;
  }

  String get code => _code;

   set code(String value) {
    _code = value;
  }

  double get poucentageRemise => _poucentageRemise;

  set poucentageRemise(double value) {
    _poucentageRemise = value;
  }



}