import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/shared_pref_helper.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/features/home/create_task/controller/add_task_controller.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/models/history_model.dart';
import 'package:home_challenger_for_flutter/models/task_model.dart';
import 'package:home_challenger_for_flutter/services/notification_service.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class PopUpDialog extends ConsumerStatefulWidget {
  const PopUpDialog({
    super.key,
    required this.edit,
    required this.delete,
    required this.model,
  });
  final VoidCallback edit;
  final VoidCallback delete;
  final TaskModel model;

  @override
  ConsumerState<PopUpDialog> createState() => _PopUpDialogState();
}

class _PopUpDialogState extends ConsumerState<PopUpDialog> {
  List<HistoryModel> historyList = [];
  int sum = 0;

  getHistory() async {
    historyList = await SharedPrefHelper.getHistoryList();
    var list = await SharedPrefHelper.getHistoryTime();
    sum = list
        .where((e) => e.id == widget.model.id)
        .map((e) => e.time ?? 0)
        .fold(0, (previousValue, element) => previousValue + element);
    setState(() {});
  }

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 240.w,
        constraints: BoxConstraints(maxHeight: 140.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: context.whiteColor),
        child: Column(
          children: [
            InkWell(
              onTap: widget.edit,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding4,
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.editSvgIcon,
                          width: 24.w, height: 24.h),
                      padding12,
                      Text(
                        LocaleKeys.edit.tr(),
                        style: getSemiBoldStyle(
                            color: MyColors.black, fontSize: MyFonts.size17),
                      ),
                    ],
                  ),
                  padding4,
                  Divider(
                    color: context.boarderColor.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: widget.delete,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding4,
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.deleteSvgIcon,
                          width: 24.w, height: 24.h),
                      padding12,
                      Text(
                        LocaleKeys.delete.tr(),
                        style: getSemiBoldStyle(
                            color: MyColors.black, fontSize: MyFonts.size17),
                      ),
                    ],
                  ),
                  padding4,
                  Divider(
                    color: context.boarderColor.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                markComplete();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding4,
                  Row(
                    children: [
                      Icon(Icons.check, color: context.primary, size: 24),
                      padding12,
                      Text(
                        LocaleKeys.markAsComplete.tr(),
                        style: getSemiBoldStyle(
                            color: MyColors.black, fontSize: MyFonts.size17),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  markComplete() async {
    TaskModel taskModel = widget.model.copyWith(
      is_completed: true,
    );
    historyList.add(HistoryModel(
        time: sum, title: widget.model.content!, id: widget.model.id));
    await ref
        .read(addTaskControllerProvider.notifier)
        .markAsClose(id: taskModel.id!, context: context);
    await SharedPrefHelper.saveHistoryList(historyList);
    await LocalNotificationService.showNotification(
      title: '${widget.model.content} Completed This Task',
      body: 'You have completed this task',
    );
  }
}
