import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/custom_button.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/routes/route_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/app_constants.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.splashIcon,
                height: 250.h,
                width: 250.w,
              ),
              padding40,
              Text(
                'Welcome to Home Challenger!',
                style: getSemiBoldStyle(
                    color: context.blackColor, fontSize: 20.sp),
              ),
              padding56,
              CommonButton(
                backColor: context.primary,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.chooseThemeScreen, (route) => false);
                },
                buttonText: 'Get Started',
                buttonHeight: 60.h,
                borderRadius: 12.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
