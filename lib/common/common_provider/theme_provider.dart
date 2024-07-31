import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';

final themeMenuProvider = ChangeNotifierProvider((ref) => ThemeController());

class ThemeController extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  void changeTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }

  void changeThemeMode() {
    themeMode = themeMode == ThemeMode.light
        ? ThemeMode.dark
        : themeMode == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.light;
    notifyListeners();
  }
}
