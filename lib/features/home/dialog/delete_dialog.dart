import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/custom_button.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/features/home/controller/home_controller.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class DeleteDialog extends ConsumerStatefulWidget {
  const DeleteDialog({super.key, required this.id});
  final String id;

  @override
  ConsumerState<DeleteDialog> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 320.w,
      decoration: BoxDecoration(
        color: context.whiteColor,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      CupertinoIcons.clear,
                      color: context.bodyTextColor,
                      size: 25.h,
                    ),
                  ),
                ],
              ),
              padding8,
              Image.asset(
                AppAssets.infoRoundIcon,
                height: 70.h,
                width: 70.w,
                color: context.primary,
              ),
              padding12,
              Text(
                LocaleKeys.AreYouSureWantToDeleteThisTask.tr(),
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: MyColors.black, fontSize: MyFonts.size15),
              ),
              padding24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      borderColor: context.secondaryContainerColor,
                      backColor: context.whiteColor,
                      buttonHeight: 38.h,
                      buttonWidth: 135.w,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      textColor: MyColors.black,
                      buttonText: LocaleKeys.cancel.tr()),
                  CustomButton(
                      isLoading: ref.watch(homeControllerProvider),
                      backColor: context.primary,
                      buttonHeight: 38.h,
                      buttonWidth: 135.w,
                      onPressed: delete,
                      textColor: MyColors.white,
                      buttonText: LocaleKeys.delete.tr()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  delete() async {
    await ref
        .read(homeControllerProvider.notifier)
        .deleteTask(id: widget.id, context: context)
        .then((value) {
      setState(() {});
    });
  }
}
