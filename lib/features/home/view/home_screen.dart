import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/shared_pref_helper.dart';
import 'package:home_challenger_for_flutter/common/common_provider/theme_provider.dart';
import 'package:home_challenger_for_flutter/common/common_shimmers/loading_images_shimmer.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/language_bottom_session.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/show_bottom_sheet.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/features/home/controller/home_controller.dart';
import 'package:home_challenger_for_flutter/features/home/widgets/In_progress_task_widget.dart';
import 'package:home_challenger_for_flutter/features/home/widgets/task_card.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/routes/route_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/app_constants.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  String theme = '';
  String color = '';

  getThemeAndColor() async {
    theme = await SharedPrefHelper.getTheme();
    color = await SharedPrefHelper.getColor();
    setState(() {});
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getThemeAndColor();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = [
      LocaleKeys.MyTask.tr(),
      LocaleKeys.InProgress.tr(),
    ];
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? context.scaffoldBackgroundColor
            : context.containerColor,
        actions: [
          InkWell(
            // ignore: deprecated_member_use
            overlayColor: MaterialStateProperty.all(MyColors.transparentColor),
            onTap: () {
              showFullBottomSheet(
                context: context,
                content: const LanguageBottomSession(),
                height: 450.h,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(
                AppAssets.languageSvgIcon,
                height: 20.h,
                width: 20.w,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          InkWell(
            // ignore: deprecated_member_use
            overlayColor: MaterialStateProperty.all(MyColors.transparentColor),
            onTap: () {
              ref.watch(themeMenuProvider.notifier).changeThemeMode();

              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(
                Theme.of(context).brightness == Brightness.light
                    ? AppAssets.darkModeSvgIcon
                    : AppAssets.lightModeSvgIcon,
                height: 20.h,
                width: 20.w,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              AppAssets.profileSvgIcon,
              height: 20.h,
              width: 20.w,
              colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SvgPicture.asset(
            AppAssets.menusSvgIcon,
            height: 20.h,
            width: 20.w,
            colorFilter: ColorFilter.mode(
              Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: _tabs.length,
        child: Padding(
          padding: EdgeInsets.all(AppConstants.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.hi.tr(),
                style: getBoldStyle(
                    color: context.blackColor, fontSize: MyFonts.size18),
              ),
              padding4,
              Text(
                LocaleKeys.haveANiceDay.tr(),
                style: getRegularStyle(
                    color: context.blackColor, fontSize: MyFonts.size14),
              ),
              padding12,
              theme == 'theme0'
                  ? SizedBox(
                      height: 55.h,
                      child: TabBar(
                        onTap: (index) {
                          setState(() {});
                        },
                        controller: _tabController,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: 5.h, left: 5.w, right: 5.w, bottom: 10.h),
                        unselectedLabelColor: context.blackColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
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
                        dividerColor: MyColors.transparentColor,
                        labelColor: context.whiteColor,
                        labelStyle: getMediumStyle(color: context.whiteColor),
                        tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
                      ),
                    )
                  : Container(),
              theme == 'theme0'
                  ? SizedBox(
                      height: 185.h,
                      child: Consumer(builder: (context, ref, child) {
                        final allTaskProvider = ref.watch(
                            watchAllTaskProvider(_tabs[_tabController.index]));
                        return allTaskProvider.when(
                          data: (data) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: data.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  if (data.isEmpty) {
                                    return Center(
                                      child: Image.asset(
                                        AppAssets.noDataIcon,
                                        height: 150.h,
                                        width: 150.w,
                                      ),
                                    );
                                  }
                                  final task = data[index];
                                  return InkWell(
                                      // ignore: deprecated_member_use
                                      overlayColor: MaterialStateProperty.all(
                                          MyColors.transparentColor),
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.detailTaskScreen,
                                          arguments: {
                                            'model': task,
                                          },
                                        );
                                      },
                                      child: TaskCard(taskModel: task));
                                });
                          },
                          loading: () {
                            return ShimmerWidget(
                              highlightColor: context.primary.withOpacity(0.5),
                              width: double.infinity,
                              height: 200,
                            );
                          },
                          error: (error, stackTrace) {
                            return Center(
                              child: Image.asset(
                                AppAssets.errorIcon,
                                height: 150.h,
                                width: 150.w,
                              ),
                            );
                          },
                        );
                      }),
                    )
                  : Expanded(
                      child: Consumer(builder: (context, ref, child) {
                        final allTaskProvider = ref.watch(
                            watchAllTaskProvider(_tabs[_tabController.index]));
                        return allTaskProvider.when(
                          data: (data) {
                            return GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: data.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 183.h,
                                        crossAxisSpacing: 0.w,
                                        mainAxisSpacing: 5.h),
                                itemBuilder: (context, index) {
                                  if (data.isEmpty) {
                                    return Center(
                                      child: Image.asset(
                                        AppAssets.noDataIcon,
                                        height: 150.h,
                                        width: 150.w,
                                      ),
                                    );
                                  }
                                  final task = data[index];
                                  return InkWell(
                                    // ignore: deprecated_member_use
                                    overlayColor: MaterialStateProperty.all(
                                        MyColors.transparentColor),
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.detailTaskScreen,
                                        arguments: {
                                          'model': task,
                                        },
                                      );
                                    },
                                    child: TaskCard(taskModel: task),
                                  );
                                });
                          },
                          loading: () {
                            return ShimmerWidget(
                              highlightColor: context.primary.withOpacity(0.5),
                              width: double.infinity,
                              height: 200,
                            );
                          },
                          error: (error, stackTrace) {
                            return Center(
                              child: Image.asset(
                                AppAssets.errorIcon,
                                height: 150.h,
                                width: 150.w,
                              ),
                            );
                          },
                        );
                      }),
                    ),
              padding12,
              theme == 'theme0' ? const InProgressTaskWidget() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
