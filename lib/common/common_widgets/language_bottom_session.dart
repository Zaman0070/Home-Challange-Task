import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/language_provider.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/utils/constants/app_constants.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class LanguageBottomSession extends ConsumerStatefulWidget {
  const LanguageBottomSession({super.key});

  @override
  ConsumerState<LanguageBottomSession> createState() =>
      _LanguageBottomSessionState();
}

class _LanguageBottomSessionState extends ConsumerState<LanguageBottomSession> {
  @override
  Widget build(BuildContext context) {
    final ctr = ref.watch(languageNotifierCtr);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                splashColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.close,
                    color: context.blackColor,
                  ),
                ))
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
          child: Text(
            LocaleKeys.selectLanguage.tr(),
            style: getBoldStyle(
                color: context.blackColor, fontSize: MyFonts.size22),
          ),
        ),
        padding12,
        Container(
          height: 25.h,
          width: 1.sw,
          color: context.textFieldColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '       ${LocaleKeys.resent.tr()}',
                style: getRegularStyle(
                    color: context.lightTextColor, fontSize: MyFonts.size12),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppConstants.padding, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    ctr.selectedLanguage == 'English' ||
                            ctr.selectedLanguage == "German"
                        ? AppAssets.germanSvgIcon
                        : AppAssets.frenchSvgIcon,
                    height: 40.h,
                    width: 40.w,
                  ),
                  padding12,
                  Text(
                    ctr.selectedLanguage == "System"
                        ? LocaleKeys.Automatic_based_on_system_language.tr()
                        : ctr.selectedLanguage,
                    style: getBoldStyle(
                        color: MyColors.green, fontSize: MyFonts.size12),
                  ),
                ],
              ),
              SvgPicture.asset(
                AppAssets.checkSvgIcon,
                height: 22.h,
                width: 22.w,
              )
            ],
          ),
        ),
        padding12,
        Container(
          height: 25.h,
          width: 1.sw,
          color: context.textFieldColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '       ${LocaleKeys.Choose_language.tr()}',
                style: getRegularStyle(
                    color: context.lightTextColor, fontSize: MyFonts.size12),
              ),
            ],
          ),
        ),
        padding12,
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppConstants.padding, vertical: 12),
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  ctr.setLanguage("English");
                  await context.setLocale(const Locale('en', "US"));
                  setState(() {});
                },
                splashColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.englishSvgIcon,
                          height: 40.h,
                          width: 40.w,
                        ),
                        padding12,
                        Text(
                          'English',
                          style: getBoldStyle(
                              color: ctr.selectedLanguage == "English"
                                  ? MyColors.green
                                  : context.blackColor,
                              fontSize: MyFonts.size12),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      ctr.selectedLanguage == "English"
                          ? AppAssets.checkSvgIcon
                          : AppAssets.unCheckSvgIcon,
                      height: 22.h,
                      width: 22.w,
                    )
                  ],
                ),
              ),
              padding24,
              InkWell(
                onTap: () async {
                  ctr.setLanguage("French");
                  await context.setLocale(const Locale('fr', "FR"));
                  setState(() {});
                },
                splashColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.frenchSvgIcon,
                          height: 40.h,
                          width: 40.w,
                        ),
                        padding12,
                        Text(
                          'French',
                          style: getBoldStyle(
                              color: ctr.selectedLanguage == "French"
                                  ? MyColors.green
                                  : context.blackColor,
                              fontSize: MyFonts.size12),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      ctr.selectedLanguage == "French"
                          ? AppAssets.checkSvgIcon
                          : AppAssets.unCheckSvgIcon,
                      height: 22.h,
                      width: 22.w,
                    )
                  ],
                ),
              ),
              padding24,
              InkWell(
                onTap: () async {
                  ctr.setLanguage("German");
                  await context.setLocale(const Locale('de', "DE"));
                  setState(() {});
                },
                splashColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.germanSvgIcon,
                          height: 40.h,
                          width: 40.w,
                        ),
                        padding12,
                        Text(
                          'German',
                          style: getBoldStyle(
                              color: ctr.selectedLanguage == "German"
                                  ? MyColors.green
                                  : context.blackColor,
                              fontSize: MyFonts.size12),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      ctr.selectedLanguage == "German"
                          ? AppAssets.checkSvgIcon
                          : AppAssets.unCheckSvgIcon,
                      height: 22.h,
                      width: 22.w,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
