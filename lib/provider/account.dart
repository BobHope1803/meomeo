import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  String _email = "",
      _displayName = "",
      _phoneNumber = "",
      _photoURL = "",
      _typeLogin = "";

  String get email => _email;

  get displayName => _displayName;

  get phoneNumber => _phoneNumber;

  get photoURL => _photoURL;

  get typeLogin => _typeLogin;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setDisplayName(String displayName) {
    _displayName = displayName;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setphotoURL(String photoURL) {
    _photoURL = photoURL;
    notifyListeners();
  }

  void setTypeLogin(String typeLogin) {
    _typeLogin = typeLogin;
    notifyListeners();
  }

  void setAll(
      {required String email,
      required String displayName,
      required String phoneNumber,
      required String photoURL,
      required String typeLogin}) {
    _email = email;
    _displayName = displayName;
    _phoneNumber = phoneNumber;
    _photoURL = photoURL;
    _typeLogin = typeLogin;
    notifyListeners();
  }

  void clearAllData(){
    _email = "";
    _displayName = "";
    _phoneNumber = "";
    _photoURL = "";
    _typeLogin = "";
    notifyListeners();
  }
}
