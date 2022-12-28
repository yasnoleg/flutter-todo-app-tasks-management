import 'package:flutter/material.dart';

class BackProvider with ChangeNotifier {

  //Background path
  String _background = 'empty';

  //Geter
  String get background => _background;

  //Read new value for provider
  void ReadBackgroundPath(String value) {
    _background = value;
    notifyListeners();
  }
}