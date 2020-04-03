import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData{

  static Future<String> getValue(@required String KEY) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(KEY);
  }

  static setValue({@required String KEY, @required String value})async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(KEY, value);
  }

  static clearLocalData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }
}