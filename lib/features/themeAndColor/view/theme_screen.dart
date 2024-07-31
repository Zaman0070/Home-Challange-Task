import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/shared_pref_helper.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/custom_button.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/routes/route_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/app_constants.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class ChoosThemeScreen extends StatefulWidget {
  const ChoosThemeScreen({super.key});

  @override
  State<ChoosThemeScreen> createState() => _ChoosThemeScreenState();
}

class _ChoosThemeScreenState extends State<ChoosThemeScreen> {
  List<String> themes = [AppAssets.theme1Image, AppAssets.theme2Image];
  int selectedTheme = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose Theme',
                style: getSemiBoldStyle(
                    color: context.blackColor, fontSize: MyFonts.size22),
              ),
              padding40,
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 150.h,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h),
                  itemBuilder: (context, index) {
                    return InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        setState(() {
                          selectedTheme = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: selectedTheme == index
                                  ? context.primary
                                  : context.lightGreyColor,
                              width: 2.w),
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(themes[index])),
                        ),
                      ),
                    );
                  }),
              padding40,
              CommonButton(
                backColor: context.primary,
                onPressed: () {
                  SharedPrefHelper.setTheme('theme$selectedTheme');
                  Navigator.pushNamed(context, AppRoutes.chooseColorScreen);
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
