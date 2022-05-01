class Client {
  String _id='' ;
  String _nom='';
  String _email='';
  String _tel='';


  Client(this._id, this._nom, this._email, this._tel);







  String get tel => _tel;

  void setTel(String value) {
    _tel = value;
  }

  String get email => _email;

  void setemail(String value) {
    _email = value;
  }

  String get nom => _nom;

  void setnom(String value) {
    _nom = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}