import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/shared_pref_helper.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/custom_button.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/routes/route_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/app_constants.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class ChooseColorScreen extends StatefulWidget {
  const ChooseColorScreen({super.key});

  @override
  State<ChooseColorScreen> createState() => _ChooseColorScreenState();
}

class _ChooseColorScreenState extends State<ChooseColorScreen> {
  int selectedColor = 0;
  List<Color> colors = [
    const Color(0xFF9C2CF3),
    const Color(0xffFC471E),
    const Color(0xff008059),
  ];
  List<int> colorsCode = [
    0xFF9C2CF3,
    0xffFC471E,
    0xff008059,
  ];
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
                'Choose Color',
                style: getSemiBoldStyle(
                    color: context.blackColor, fontSize: MyFonts.size22),
              ),
              padding40,
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 150.h,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h),
                  itemBuilder: (context, index) {
                    return InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        setState(() {
                          selectedColor = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(colorsCode[index]),
                          border: Border.all(
                              color: selectedColor == index
                                  ? MyColors.green
                                  : context.lightGreyColor,
                              width: 2.w),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    );
                  }),
              padding40,
              CommonButton(
                backColor: context.primary,
                onPressed: () {
                  SharedPrefHelper.setColor('color$selectedColor');
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.mainMenuScreen, (route) => false);
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
