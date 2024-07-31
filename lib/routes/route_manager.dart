import 'package:flutter/material.dart';
import 'package:home_challenger_for_flutter/features/home/create_task/view/create_task_screen.dart';
import 'package:home_challenger_for_flutter/features/home/create_task/view/edit_task_screen.dart';
import 'package:home_challenger_for_flutter/features/home/view/task_details_screen.dart';
import 'package:home_challenger_for_flutter/features/main_menu/views/main_menu_screen.dart';
import 'package:home_challenger_for_flutter/features/splash/view/splash_screen.dart';
import 'package:home_challenger_for_flutter/features/themeAndColor/view/color_screen.dart';
import 'package:home_challenger_for_flutter/features/themeAndColor/view/theme_screen.dart';

import 'navigation.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String chooseThemeScreen = '/chooseThemeScreen';
  static const String chooseColorScreen = '/chooseColorScreen';
  static const String mainMenuScreen = '/mainMenuScreen';
  static const String createTaskScreen = '/createTaskScreen';
  static const String editTaskScreen = '/editTaskScreen';
  static const String detailTaskScreen = '/detailTaskScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return _buildRoute(const SplashScreen());
      case chooseThemeScreen:
        return _buildRoute(const ChoosThemeScreen());
      case chooseColorScreen:
        return _buildRoute(const ChooseColorScreen());
      case mainMenuScreen:
        return _buildRoute(const MainMenuScreen());
      case createTaskScreen:
        return _buildRoute(const CreateTaskScreen());
      case editTaskScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(EditTaskScreen(
          model: args['model'],
        ));
      case detailTaskScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(TaskDetailScreen(
          model: args['model'],
        ));

      default:
        return unDefinedRoute();
    }
  }

  static unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              backgroundColor: Colors.white,
            ));
  }

  static _buildRoute(Widget widget, {int? duration = 400}) {
    return forwardRoute(widget, duration);
  }

  static _buildNormalRoute(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }
}
