import 'package:meomeo/provider/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


//Set Auto Fill data to TextFormField
//Controller textfield
TextEditingController getDataTextField(String txt) {
  if (txt == null) txt = '';
  final TextEditingController _controller = TextEditingController();
  _controller.value = _controller.value.copyWith(
    text: txt,
    selection: TextSelection.collapsed(offset: txt.length),
  );
  return _controller;
}

//Save data login
saveDataLogin({required String typeLogin, UserCredential? user}) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("email", user?.user?.email ?? "");
  prefs.setString("displayName", user?.user?.displayName ?? "");
  prefs.setString("phoneNumber", user?.user?.phoneNumber ?? "");
  prefs.setString("photoURL", typeLogin == "google" ? user?.user?.photoURL : user?.additionalUserInfo?.profile?["picture"]["data"]["url"] ?? "");
  prefs.setString("typeLogin", typeLogin);
  prefs.setBool("isLogin", true);
}

//Get local data login
getLocalDataLogin({required AccountProvider provider}) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  provider.setAll(email: prefs.getString("email").toString(),
      displayName: prefs.getString("displayName").toString(),
      phoneNumber: prefs.getString("phoneNumber").toString(),
      photoURL: prefs.getString("photoURL").toString(),
      typeLogin: prefs.getString("typeLogin").toString());
}

//Clear all data
clearAllData({required AccountProvider provider}) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  provider.clearAllData();
}

//Get data
Future getLocalData({required String nameOfData}) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(nameOfData);
}