import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/shared_pref_helper.dart';
import 'package:home_challenger_for_flutter/common/common_shimmers/loading_images_shimmer.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/features/home/controller/home_controller.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/utils/constants/app_constants.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewScreen extends ConsumerStatefulWidget {
  const CalendarViewScreen({super.key});

  @override
  ConsumerState<CalendarViewScreen> createState() => _CalendarViewScreenState();
}

class _CalendarViewScreenState extends ConsumerState<CalendarViewScreen> {
  String color = '';

  getColor() async {
    color = await SharedPrefHelper.getColor();
    setState(() {});
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List> _eventsList = {};

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    getColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? context.scaffoldBackgroundColor
            : context.containerColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            AppAssets.backArrowIcon,
            width: 20.w,
            height: 20.h,
            color: context.blackColor,
          ),
        ),
        title: Text(
          LocaleKeys.Calendar.tr(),
          style: getSemiBoldStyle(
              color: context.blackColor, fontSize: MyFonts.size18),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Consumer(builder: (context, ref, child) {
          final watchAllTaskProvider =
              ref.watch(watchAllTaskInProgressProvider);
          return watchAllTaskProvider.when(data: (data) {
            _eventsList = {
              for (var task in data)
                DateTime.parse(task.due!.date!): [
                  task.content,
                ]
            };
            final events = LinkedHashMap<DateTime, List>(
              equals: isSameDay,
              hashCode: getHashCode,
            )..addAll(_eventsList);

            List getEventForDay(DateTime day) {
              return events[day] ?? [];
            }

            return Column(
              children: [
                TableCalendar(
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: color == 'color1'
                          ? MyColors.primary1Color
                          : color == 'color2'
                              ? MyColors.primary2Color
                              : context.primary,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: color == 'color1'
                          ? MyColors.primary1Color
                          : color == 'color2'
                              ? MyColors.primary2Color
                              : context.primary,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: getBoldStyle(
                        color: MyColors.white, fontSize: MyFonts.size16),
                  ),
                  firstDay: DateTime.utc(2021, 1, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  focusedDay: _focusedDay,
                  eventLoader: getEventForDay,
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                ListView(
                  shrinkWrap: true,
                  children: getEventForDay(_selectedDay!)
                      .map((event) => ListTile(
                            title: Text(event.toString()),
                          ))
                      .toList(),
                )
              ],
            );
          }, error: (e, s) {
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
      ),
    );
  }
}
