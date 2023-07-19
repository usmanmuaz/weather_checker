

import 'package:flutter/widgets.dart';

class ThemeProvider with ChangeNotifier{
bool _darkTheme = false;
bool get darkTheme => _darkTheme;

void setDarkTheme(){
  _darkTheme = !_darkTheme;
  notifyListeners();
}
}