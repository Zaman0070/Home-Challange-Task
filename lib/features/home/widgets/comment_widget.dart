import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_shimmers/loading_images_shimmer.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/features/home/controller/home_controller.dart';
import 'package:home_challenger_for_flutter/models/task_model.dart';
import 'package:home_challenger_for_flutter/utils/constants/app_constants.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key, required this.model});
  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(builder: (context, ref, child) {
        final commentStream = ref.watch(watchAllCommentsProvider(model.id!));

        return commentStream.when(data: (data) {
          return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
              itemCount: data!.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(8.r),
                  margin: EdgeInsets.only(bottom: 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    gradient: LinearGradient(colors: [
                      context.primary.withOpacity(0.2),
                      context.secondary.withOpacity(0.2),
                    ]),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].content ?? '',
                        style: getSemiBoldStyle(
                            color: context.blackColor,
                            fontSize: MyFonts.size18),
                      ),
                      padding2,
                      // time
                      Text(
                        data[index].posted_at ?? '',
                        style: getRegularStyle(
                            color: context.darkGreyColor,
                            fontSize: MyFonts.size12),
                      ),
                    ],
                  ),
                );
              });
        }, error: (e, st) {
          return ShimmerWidget(
            highlightColor: context.primary.withOpacity(0.5),
            width: double.infinity,
            height: 200,
          );
        }, loading: () {
          return ShimmerWidget(
            highlightColor: context.primary.withOpacity(0.5),
            width: double.infinity,
            height: 200,
          );
        });
      }),
    );
  }
}
