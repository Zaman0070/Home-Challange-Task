import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_challenger_for_flutter/common/common_functions/formated_date.dart';
import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/shared_pref_helper.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/custom_button.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/custom_text_fields.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/show_toast.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/features/home/controller/home_controller.dart';
import 'package:home_challenger_for_flutter/features/home/widgets/comment_widget.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/models/comment_model.dart';
import 'package:home_challenger_for_flutter/models/history_model.dart';
import 'package:home_challenger_for_flutter/models/task_model.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  const TaskDetailScreen({super.key, required this.model});
  final TaskModel model;

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  late Timer _timer;
  int _elapsed = 0;
  bool _isRunning = false;
  List<HistoryModel> timeList = [];
  int sum = 0;
  String color = '';
  getColor() async {
    color = await SharedPrefHelper.getColor();
    setState(() {});
  }

  getHistory() async {
    timeList = await SharedPrefHelper.getHistoryTime();

    // await SharedPrefHelper.clearAllData();
    setState(() {});
  }

  @override
  void initState() {
    getColor();
    getHistory();
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _elapsed++;
      });
    });

    setState(() {
      _isRunning = true;
    });
  }

  void _pauseTimer() {
    _timer.cancel();
    timeList.add(HistoryModel(
      title: widget.model.content,
      time: _elapsed,
      id: widget.model.id,
    ));
    SharedPrefHelper.saveHistoryTime(timeList);
    showToast(
        msg: 'Task time save in your history', backgroundColor: MyColors.green);
    setState(() {
      _isRunning = false;
      _elapsed = 0;
    });
  }

  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(14.r),
            height: 280.h,
            decoration: BoxDecoration(
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
                padding40,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      overlayColor:
                          MaterialStateProperty.all(MyColors.transparentColor),
                      onTap: () {
                        if (_isRunning) {
                          _pauseTimer();
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                            color: context.whiteColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(4.r)),
                        child: Image.asset(
                          AppAssets.backArrowIcon,
                          height: 19.h,
                          width: 19.w,
                          color: context.whiteColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        CommonButton(
                          onPressed: _isRunning ? _pauseTimer : _startTimer,
                          buttonText: _isRunning
                              ? LocaleKeys.pause.tr()
                              : LocaleKeys.start.tr(),
                          backColor: context.whiteColor,
                          textColor: MyColors.black,
                          buttonHeight: 28.h,
                          buttonWidth: 55.w,
                          borderRadius: 4.r,
                        ),
                        padding16,
                        Text(formatTimeSecond(_elapsed),
                            style: getSemiBoldStyle(
                                color: context.whiteColor,
                                fontSize: MyFonts.size22)),
                      ],
                    ),
                  ],
                ),
                padding24,
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
                    padding8,
                    Text.rich(
                      TextSpan(
                        text: '${LocaleKeys.projectID.tr()} ',
                        style: getBoldStyle(
                            color: context.whiteColor,
                            fontSize: MyFonts.size22),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.model.project_id,
                            style: getRegularStyle(
                                color: context.whiteColor,
                                fontSize: MyFonts.size12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                padding6,
                Text(
                  widget.model.content ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getBoldStyle(
                      color: context.whiteColor, fontSize: MyFonts.size24),
                ),
                padding6,
                Text(widget.model.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getRegularStyle(
                        color: context.whiteColor, fontSize: MyFonts.size13)),
                padding8,
                Text(
                  LocaleKeys.InProgress.tr(),
                  style: getRegularStyle(
                      color: context.whiteColor, fontSize: MyFonts.size12),
                ),
                padding4,
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  children: widget.model.labels!
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
              ],
            ),
          ),
          padding18,
          Text(
            '    ${LocaleKeys.comment.tr()}',
            style: getSemiBoldStyle(
                color: context.blackColor, fontSize: MyFonts.size18),
          ),
          padding12,
          CommentWidget(model: widget.model),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(10.r),
        height: 100.h,
        decoration: BoxDecoration(
          color: context.whiteColor,
          boxShadow: [
            BoxShadow(
              color: context.blackColor.withOpacity(0.1),
              blurRadius: 10.r,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomTextField(
                hintText: LocaleKeys.addAComment.tr(),
                controller: commentController,
              ),
            ),
            padding12,
            InkWell(
              onTap: addComment,
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12.h),
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.r),
                    color: color == 'color1'
                        ? MyColors.primary1Color
                        : color == 'color2'
                            ? MyColors.primary2Color
                            : context.primary,
                  ),
                  child: Center(
                    child: Text(
                      LocaleKeys.add.tr(),
                      style: getSemiBoldStyle(
                          color: context.whiteColor, fontSize: MyFonts.size14),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  addComment() async {
    CommentModel comment = CommentModel(
      content: commentController.text,
      task_id: widget.model.id,
    );
    await ref
        .read(homeControllerProvider.notifier)
        .createComment(formData: comment, context: context);
    commentController.clear();
  }
}
