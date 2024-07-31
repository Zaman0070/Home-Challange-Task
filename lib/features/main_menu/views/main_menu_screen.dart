import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/shared_pref_helper.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';

import 'dart:io' show Platform;

import 'package:home_challenger_for_flutter/features/main_menu/controller/main_menu_controller.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/routes/route_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class MainMenuScreen extends ConsumerStatefulWidget {
  const MainMenuScreen({super.key});

  @override
  ConsumerState<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends ConsumerState<MainMenuScreen>
    with WidgetsBindingObserver {
  String color = '';

  /// Here in this method, we are initializing necessary methods
  initialization() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final mainMenuCtr = ref.read(usermainMenuProvider);
      mainMenuCtr.setIndex(0);
    });
  }

  getColor() async {
    color = await SharedPrefHelper.getColor();
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    initialization();
    getColor();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // sendNotification();
    final mainMenuCtr = ref.watch(usermainMenuProvider);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: color == 'color1'
            ? MyColors.primary1Color
            : color == 'color2'
                ? MyColors.primary2Color
                : context.primary,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.createTaskScreen);
        },
        child: const Icon(Icons.add),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: context.primary.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -1), // changes position of shadow
          ),
        ]),
        height: Platform.isIOS ? 90.h : 78.h,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: color == 'color1'
              ? MyColors.primary1Color
              : color == 'color2'
                  ? MyColors.primary2Color
                  : context.primary,
          currentIndex: mainMenuCtr.index,
          selectedLabelStyle:
              getBoldStyle(color: context.primary, fontSize: MyFonts.size10),
          unselectedLabelStyle: getSemiBoldStyle(
              color: context.lightTextColor, fontSize: MyFonts.size10),
          items: [
            navigationItem(
                icon: AppAssets.homeSvgIcon,
                activeIcon: AppAssets.homeSvgIcon,
                label: LocaleKeys.home.tr().toUpperCase()),
            navigationItem(
                icon: AppAssets.historySvgIcon,
                activeIcon: AppAssets.historySvgIcon,
                label: LocaleKeys.history.tr().toUpperCase()),
          ],
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? context.scaffoldBackgroundColor
              : context.containerColor,
          elevation: 10,
          onTap: (index) {
            mainMenuCtr.setIndex(index);
            mainMenuCtr.pageController.jumpToPage(index);
            // pageController.jumpToPage(tabIndex);
          },
        ),
      ),
      body: PageView(
        controller: mainMenuCtr.pageController,
        onPageChanged: (v) {
          mainMenuCtr.setIndex(v);
        },
        children: [mainMenuCtr.screens[mainMenuCtr.index]],
      ),
    );
  }

  navigationItem({
    required String icon,
    required String activeIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        height: 24.h,
        width: 24.w,
      ),
      activeIcon: SvgPicture.asset(
        activeIcon,
        height: 24.h,
        width: 24.w,
        colorFilter: ColorFilter.mode(
            color == 'color1'
                ? MyColors.primary1Color
                : color == 'color2'
                    ? MyColors.primary2Color
                    : context.primary,
            BlendMode.srcIn),
      ),
      label: label,
    );
  }
}
