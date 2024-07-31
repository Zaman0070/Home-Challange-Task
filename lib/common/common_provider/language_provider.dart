import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageNotifierCtr =
    ChangeNotifierProvider((ref) => LanguageController());

class LanguageController extends ChangeNotifier {
  String selectedLanguage = 'System';

  setLanguage(String value) async {
    selectedLanguage = value;
    notifyListeners();
  }
}
