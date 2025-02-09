import 'package:flutter/material.dart';

class GenreProvider extends ChangeNotifier {
  String _value = 'Shooter';
  String get value => _value;
  set value(String n){
    _value = n;
    notifyListeners(); 
  }
}