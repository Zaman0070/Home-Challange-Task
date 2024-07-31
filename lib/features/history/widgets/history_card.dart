import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_challenger_for_flutter/common/common_functions/formated_date.dart';
import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/shared_pref_helper.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/models/history_model.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({super.key, required this.model});
  final HistoryModel model;

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  String color = '';
  getColor() async {
    color = await SharedPrefHelper.getColor();
    setState(() {});
  }

  @override
  void initState() {
    getColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      margin: EdgeInsets.only(bottom: 12.h),
      height: 65.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: context.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 33.h,
                width: 33.w,
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    gradient: color == 'color1'
                        ? const LinearGradient(colors: [
                            MyColors.primary1Color,
                            MyColors.secondary1Color,
                          ])
                        : color == 'color2'
                            ? const LinearGradient(colors: [
                                MyColors.primary2Color,
                                MyColors.secondary2Color,
                              ])
                            : LinearGradient(colors: [
                                context.primary,
                                context.secondary,
                              ])),
                child: SvgPicture.asset(
                  AppAssets.projectSvgIcon,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
              padding12,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.title ?? '',
                    style: getSemiBoldStyle(
                        color: MyColors.black, fontSize: MyFonts.size16),
                  ),
                  Text(
                    '${formatTimeSecond(widget.model.time!)} ${LocaleKeys.TimeSpentonTask.tr()}',
                    style: getRegularStyle(
                        color: context.darkGreyColor, fontSize: MyFonts.size13),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
