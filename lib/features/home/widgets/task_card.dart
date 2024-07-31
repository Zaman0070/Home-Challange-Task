import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/shared_pref_helper.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/show_dialog.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/features/home/dialog/delete_dialog.dart';
import 'package:home_challenger_for_flutter/features/home/dialog/popup_dialog.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/models/task_model.dart';
import 'package:home_challenger_for_flutter/routes/route_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class TaskCard extends ConsumerStatefulWidget {
  const TaskCard({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  ConsumerState<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<TaskCard> {
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
      padding: EdgeInsets.all(14.r),
      margin: EdgeInsets.only(right: 12.w),
      height: 183.h,
      width: 183.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                height: 28.h,
                width: 28.w,
                decoration: BoxDecoration(
                    color: context.whiteColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(4.r)),
                child: SvgPicture.asset(
                  AppAssets.projectSvgIcon,
                  height: 19.h,
                  width: 19.w,
                ),
              ),
              padding4,
              Text.rich(
                TextSpan(
                  text: '${LocaleKeys.projectID.tr()}: \n',
                  style: getBoldStyle(
                      color: context.whiteColor, fontSize: MyFonts.size16),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.taskModel.project_id,
                      style: getRegularStyle(
                          color: context.whiteColor, fontSize: MyFonts.size9),
                    ),
                  ],
                ),
              ),
            ],
          ),
          padding6,
          Text(
            widget.taskModel.content ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getBoldStyle(
                color: context.whiteColor, fontSize: MyFonts.size22),
          ),
          padding2,
          Text(widget.taskModel.description ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: getRegularStyle(
                  color: context.whiteColor, fontSize: MyFonts.size12)),
          padding4,
          Text(
            LocaleKeys.InProgress.tr(),
            style: getRegularStyle(
                color: context.whiteColor, fontSize: MyFonts.size12),
          ),
          padding4,
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: widget.taskModel.labels!
                .map((label) => Container(
                      margin: EdgeInsets.only(right: 4.w),
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                          color: context.whiteColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(4.r)),
                      child: Text(
                        "@$label",
                        style: getRegularStyle(
                            color: context.whiteColor,
                            fontSize: MyFonts.size10),
                      ),
                    ))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomPopup(
                  barrierColor: context.primary.withOpacity(0.1),
                  backgroundColor: Colors.white,
                  content: PopUpDialog(
                    model: widget.taskModel,
                    edit: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppRoutes.editTaskScreen,
                          arguments: {
                            'model': widget.taskModel,
                          });
                    },
                    delete: () {
                      Navigator.pop(context);
                      showCustomDialog(
                        context: context,
                        content: DeleteDialog(id: widget.taskModel.id!),
                      );
                    },
                  ),
                  child: Container(
                    height: 25.h,
                    width: 25.w,
                    padding: EdgeInsets.all(6.r),
                    child: SvgPicture.asset(AppAssets.moreSvgIcon,
                        height: 20.h,
                        width: 20.w,
                        colorFilter: ColorFilter.mode(
                            context.lightGreyColor, BlendMode.srcIn)),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
