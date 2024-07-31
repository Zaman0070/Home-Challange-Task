import 'package:flutter_svg/svg.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';
import 'package:home_challenger_for_flutter/utils/loading.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false,
    this.backColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.fontSize,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.buttonIcon,
  });

  final Function()? onPressed;
  final String buttonText;
  final bool isLoading;
  final Color? backColor;
  final Color? textColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? fontSize;
  final double? padding;
  final double? borderRadius;
  final Color? borderColor;
  final String? buttonIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('customButton'),
      height: buttonHeight ?? 45.h,
      padding: EdgeInsets.symmetric(horizontal: padding ?? 4.w),
      margin: EdgeInsets.symmetric(
        vertical: padding ?? 10.h,
      ),
      child: RawMaterialButton(
        splashColor: MyColors.transparentColor,
        elevation: 2,
        fillColor: backColor,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 50.r),
          side: BorderSide(color: borderColor ?? Colors.transparent, width: 2),
        ),
        child: SizedBox(
          // padding: EdgeInsets.symmetric(vertical: 10.h),
          width: buttonWidth ?? double.infinity,
          height: buttonHeight ?? 45.h,
          child: Center(
              child: isLoading
                  ? LoadingWidget(
                      color: context.whiteColor,
                      backColor: MyColors.transparentColor,
                    )
                  : buttonIcon != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              buttonIcon!,
                              width: 18.w,
                              height: 18.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                buttonText,
                                style: getSemiBoldStyle(
                                    color: textColor ?? context.buttonColor,
                                    fontSize: fontSize ?? MyFonts.size16),
                              ),
                            ),
                          ],
                        )
                      : FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            buttonText,
                            style: getSemiBoldStyle(
                                color: textColor ?? context.buttonColor,
                                fontSize: fontSize ?? MyFonts.size18),
                          ),
                        )),
        ),
      ),
    );
  }
}

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false,
    this.backColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.fontSize,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.buttonIcon,
    this.rotate = 0,
  });

  final Function()? onPressed;
  final String buttonText;
  final bool isLoading;
  final Color? backColor;
  final Color? textColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? fontSize;
  final double? padding;
  final double? borderRadius;
  final Color? borderColor;
  final String? buttonIcon;
  final int rotate;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('customButton'),
      height: buttonHeight ?? 45.h,
      margin: EdgeInsets.symmetric(vertical: padding ?? 10.h),
      child: RawMaterialButton(
        splashColor: MyColors.transparentColor,
        elevation: 2,
        fillColor: backColor,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 50.r),
          side: BorderSide(color: borderColor ?? Colors.transparent, width: 2),
        ),
        child: SizedBox(
          // padding: EdgeInsets.symmetric(vertical: 10.h),
          width: buttonWidth ?? double.infinity,
          height: buttonHeight ?? 45.h,
          child: Center(
              child: isLoading
                  ? LoadingWidget(color: context.buttonColor)
                  : buttonIcon != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              buttonText,
                              style: getSemiBoldStyle(
                                  color: textColor ?? context.buttonColor,
                                  fontSize: fontSize ?? MyFonts.size16),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            RotatedBox(
                              quarterTurns: rotate,
                              child: Image.asset(
                                buttonIcon!,
                                width: 18.w,
                                height: 18.h,
                                color: context.primary,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          buttonText,
                          style: getSemiBoldStyle(
                              color: textColor ?? context.buttonColor,
                              fontSize: fontSize ?? MyFonts.size18),
                        )),
        ),
      ),
    );
  }
}
