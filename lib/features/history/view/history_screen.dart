import 'package:easy_localization/easy_localization.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/shared_pref_helper.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/features/history/widgets/history_card.dart';
import 'package:home_challenger_for_flutter/features/main_menu/controller/main_menu_controller.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/models/history_model.dart';
import 'package:home_challenger_for_flutter/utils/constants/app_constants.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  List<HistoryModel> list = [];
  List<int> time = [];

  getHistory() async {
    list = await SharedPrefHelper.getHistoryList();
    setState(() {});
  }

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? context.scaffoldBackgroundColor
            : context.containerColor,
        leading: Consumer(builder: (context, ref, child) {
          return IconButton(
            onPressed: () {
              final mainMenuCtr = ref.read(usermainMenuProvider);
              mainMenuCtr.setIndex(0);
            },
            icon: Image.asset(
              AppAssets.backArrowIcon,
              width: 20.w,
              height: 20.h,
              color: context.blackColor,
            ),
          );
        }),
        title: Text(
          LocaleKeys.completeTaskHistory.tr(),
          style: getSemiBoldStyle(
              color: context.blackColor, fontSize: MyFonts.size18),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(AppConstants.padding),
          itemCount: list.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            HistoryModel model = list[index];
            return HistoryCard(
              model: model,
            );
          }),
    );
  }
}
