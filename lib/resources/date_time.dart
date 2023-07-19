import 'dart:core';
import 'package:intl/intl.dart';
String getTimeFormated(){
  var now = DateTime.now();
  var formatter = DateFormat('EEE, d MMM');
  return formatter.format(now);
}