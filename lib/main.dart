import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_challenger_for_flutter/common/common_provider/theme_provider.dart';
import 'package:home_challenger_for_flutter/features/splash/view/splash_screen.dart';
import 'package:home_challenger_for_flutter/generated/codegen_loader.g.dart';
import 'package:home_challenger_for_flutter/routes/route_manager.dart';
import 'package:home_challenger_for_flutter/services/notification_service.dart';
import 'package:home_challenger_for_flutter/utils/constants/app_constants.dart';
import 'package:home_challenger_for_flutter/utils/thems/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.requestPermission(Permission.notification);
  LocalNotificationService.initialize();
  tz.initializeTimeZones();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('de', 'DE'),
        Locale('fr', 'FR')
      ],
      saveLocale: true,
      assetLoader: const CodegenLoader(),
      path: 'assets/l10n',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('en', 'US'),
      child: const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final themeCtr = ref.watch(themeMenuProvider);
    return ScreenUtilInit(
      designSize: Size(AppConstants.screenWidget, AppConstants.screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);
            //Text is generally big on IOS ro that why we set text scale factor for IOS to 0.9
            return MediaQuery(
              data: data.copyWith(
                  textScaleFactor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? 0.9
                          : 1),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'Home Challenger',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: lightThemeData(context),
          themeMode: themeCtr.themeMode,
          darkTheme: darkThemeData(context),

          // darkTheme: darkThemeData(context),
          onGenerateRoute: AppRoutes.onGenerateRoute,
          home: const SplashScreen(),
        );
      },
    );
  }
}
