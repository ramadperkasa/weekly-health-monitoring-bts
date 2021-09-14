import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_whm/db/db_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountData extends ChangeNotifier {
  var dBAccount = DBAccount();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool isLoading = true;

  bool isEdited = true;

  Map<String, dynamic> account = {
    "image": "assets/images/avatar.png",
    "image_local": "assets/images/avatar.png",
    "name": "Rama Dwiyantara Perkasa",
    "position": "Junior Developer",
    "nik": "ITA.EMP.00103",
    "email": "rama.d@bts.id",
    "phone_number": "088971753162",
    "gender": "L",
  };

  String urlTemp;
  String urlTempLocal;

  String getCurrentEmail() {
    return FirebaseAuth.instance.currentUser.email.toString();
  }

  setIsEdited(value) {
    isEdited = value;
  }

  setUrlTemp(String value) {
    urlTemp = value;

    notifyListeners();
  }

  setUrlLocalTemp(String value) {
    urlTempLocal = value;

    notifyListeners();
  }

  setAccount(key, value) async {
    account[key] = value;

    await saveToDb(key, value);

    notifyListeners();
  }

  saveToDb(key, value) async {
    final SharedPreferences prefs = await _prefs;

    final accounts = (prefs.getString(key.toString()) ?? account[key]);

    prefs.setString(key, value).then((bool success) async {
      return accounts;
    });
  }

  Future<String> getAccount(key) async {
    final SharedPreferences prefs = await _prefs;

    account[key] = (prefs.getString(key.toString()) ?? account[key]);

    return prefs.getString(key.toString()) ?? account[key];
  }
}
