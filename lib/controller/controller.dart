import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Controller {

  static final ValueNotifier currentindex = ValueNotifier(0);

  static TextEditingController name = TextEditingController();
  static TextEditingController age = TextEditingController();
  static bool male = true;

  static DateTime focusday = DateTime.now();
}

String format(String format,DateTime date) => DateFormat(format).format(date);

