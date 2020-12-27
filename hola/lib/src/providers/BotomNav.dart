import 'package:flutter/material.dart';

class BotomNav extends ChangeNotifier {
  int defaut = 0;
  void setSave(int a) {
    defaut = a;
    notifyListeners();
  }

  int getDefault() {
    return defaut;
  }
}
