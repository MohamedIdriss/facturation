class Article {
  String id;
  String description;
  double prix;
  bool tva;
  double poucentageTva;

  Article({this.id='',this.description = "", this.prix = 0.0, this.tva=true,this.poucentageTva=0});

  double getprix() => prix;



  void setprix(double value) {
    prix = value;
  }

  String getdescription() => description;

  void setdescription(String value) {
    description = value;
  }
  bool getTva() => tva;
}
