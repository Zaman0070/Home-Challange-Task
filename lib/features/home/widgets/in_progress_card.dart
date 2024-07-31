import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/shared_pref_helper.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/show_dialog.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/features/home/create_task/controller/add_task_controller.dart';
import 'package:home_challenger_for_flutter/features/home/dialog/delete_dialog.dart';
import 'package:home_challenger_for_flutter/features/home/dialog/popup_dialog.dart';
import 'package:home_challenger_for_flutter/models/task_model.dart';
import 'package:home_challenger_for_flutter/routes/route_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class InProgressCard extends ConsumerStatefulWidget {
  const InProgressCard({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  ConsumerState<InProgressCard> createState() => _InProgressCardState();
}

class _InProgressCardState extends ConsumerState<InProgressCard> {
  String color = '';
  String daysAgo = '';

  getColor() async {
    color = await SharedPrefHelper.getColor();
    setState(() {});
  }

  @override
  void initState() {
    getColor();

    daysAgo = DateTime.now()
        .difference(DateTime.parse(widget.taskModel.created_at!))
        .inDays
        .toString();
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
                  AppAssets.tasksSvgIcon,
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
                    widget.taskModel.content ?? '',
                    style: getSemiBoldStyle(
                      color: Colors.black,
                      fontSize: MyFonts.size16,
                    ),
                  ),
                  Text(
                    "$daysAgo days ago",
                    style: getRegularStyle(
                        color: context.darkGreyColor, fontSize: MyFonts.size13),
                  ),
                ],
              ),
            ],
          ),
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
                height: 35.h,
                width: 35.w,
                padding: EdgeInsets.all(6.r),
                child: SvgPicture.asset(AppAssets.moreSvgIcon,
                    height: 20.h,
                    width: 20.w,
                    colorFilter: ColorFilter.mode(
                        context.lightGreyColor, BlendMode.srcIn)),
              )),
        ],
      ),
    );
  }

  markComplete(TaskModel task) async {
    TaskModel taskModel = task.copyWith(
      is_completed: true,
    );
    await ref
        .read(addTaskControllerProvider.notifier)
        .markAsClose(id: taskModel.id!, context: context);
  }
}
