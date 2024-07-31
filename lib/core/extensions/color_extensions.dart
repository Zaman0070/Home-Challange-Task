import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';

extension ThemeColors on BuildContext {
  Color get blackColor => Theme.of(this).colorScheme.primary;
  Color get bodyTextColor => Theme.of(this).colorScheme.onSecondary;
  Color get buttonColor => Theme.of(this).colorScheme.onPrimary;
  Color get onSecondaryColor => Theme.of(this).colorScheme.onSecondary;
  Color get containerColor => Theme.of(this).colorScheme.primaryContainer;
  Color get secondaryContainerColor =>
      Theme.of(this).colorScheme.secondaryContainer;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get primary => MyColors.primaryColor;
  Color get secondary => MyColors.secondaryColor;
  Color get lightTextColor => MyColors.lightLightTextColor;
  Color get lightContainerColor => MyColors.lightLightTextColor;
  Color get textFieldColor => MyColors.textFieldColor;
  Color get backgroundColor => MyColors.backgroundColor;
  Color get whiteColor => MyColors.white;
  Color get darkGreyColor => MyColors.darkGreyColor;
  Color get lightGreyColor => MyColors.lightGreyColor;
  Color get boarderColor => MyColors.boarderColor;

  // theme mode
  Brightness get themeMode => Theme.of(this).brightness;
  
}
