import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';

showBottom({
  required BuildContext context,
  required Widget content,
  required double height,
  Color? barrierColor,
}) {
  return showModalBottomSheet(
      anchorPoint: const Offset(5, 0),
      isScrollControlled: true,
      backgroundColor: MyColors.transparentColor,
      barrierColor: barrierColor,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.r),
                        child: Scaffold(
                          backgroundColor:
                              context.scaffoldBackgroundColor.withOpacity(0.8),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.r),
                        child: Scaffold(
                          resizeToAvoidBottomInset: true,
                          body: SingleChildScrollView(
                            child: Column(
                              children: [
                                content,
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

showSimpleBottom(
    {required BuildContext context,
    required Widget content,
    required double height,
    Color? barrierColor}) {
  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: MyColors.transparentColor,
      barrierColor: barrierColor,
      context: context,
      builder: (context) {
        return SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: content,
                )),
          ),
        );
      });
}

showFullBottomSheet(
    {required BuildContext context,
    required Widget content,
    required double height,
    Color? barrierColor}) {
  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: MyColors.transparentColor,
      barrierColor: barrierColor,
      context: context,
      builder: (context) {
        return SizedBox(
          height: height,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Scaffold(
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? context.scaffoldBackgroundColor
                        : context.containerColor,
                resizeToAvoidBottomInset: false,
                body: content,
              )),
        );
      });
}
