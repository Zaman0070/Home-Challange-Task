import 'package:easy_localization/easy_localization.dart';
import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_shimmers/loading_images_shimmer.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/features/home/controller/home_controller.dart';
import 'package:home_challenger_for_flutter/features/home/widgets/in_progress_card.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/routes/route_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class InProgressTaskWidget extends StatelessWidget {
  const InProgressTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.InProgressTask.tr(),
              style: getSemiBoldStyle(
                  color: context.blackColor, fontSize: MyFonts.size18),
            ),
            padding12,
            Consumer(builder: (context, ref, child) {
              final allTaskProvider = ref.watch(watchAllTaskInProgressProvider);
              return allTaskProvider.when(data: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final taskModel = data[index];
                    if (data.isEmpty) {
                      return Center(
                        child: Image.asset(
                          AppAssets.noDataIcon,
                          height: 150.h,
                          width: 150.w,
                        ),
                      );
                    }
                    return InkWell(
                        overlayColor: MaterialStateProperty.all(
                            MyColors.transparentColor),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailTaskScreen,
                            arguments: {
                              'model': taskModel,
                            },
                          );
                        },
                        child: InProgressCard(taskModel: taskModel));
                  },
                );
              }, error: (e, s) {
                return Center(
                  child: Image.asset(
                    AppAssets.errorIcon,
                    height: 150.h,
                    width: 150.w,
                  ),
                );
              }, loading: () {
                return ShimmerWidget(
                  highlightColor: context.primary.withOpacity(0.5),
                  width: double.infinity,
                  height: 200,
                );
              });
            }),
          ],
        ),
      ),
    );
  }
}
