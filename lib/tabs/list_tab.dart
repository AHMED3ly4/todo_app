import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/setting_provider.dart';

import '../widgets/task_item.dart';
class ListTab extends StatelessWidget {
  static const String routeName='list tab';
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider =Provider.of(context);
    return Column(
      children: [
      TimelineCalendar(
      calendarType: CalendarType.GREGORIAN,

      calendarLanguage: 'en',
      calendarOptions: CalendarOptions(
        viewType: ViewType.DAILY,
        toggleViewType: true,
        headerMonthElevation: 0,
        headerMonthBackColor: Colors.transparent,
      ),
      dayOptions: DayOptions(
          compactMode: true,
          weekDaySelectedColor: AppTheme.blue,
          selectedBackgroundColor: AppTheme.blue,
          disableDaysBeforeNow: true,
      ),
      headerOptions: HeaderOptions(
          weekDayStringType: WeekDayStringTypes.SHORT,
          monthStringType: MonthStringTypes.FULL,
          backgroundColor: AppTheme.blue,
          headerTextColor: Colors.black,
      ),
      onChangeDateTime: (datetime) {
        print(datetime.getDate());
      },
    ),
        Expanded(
          child: ListView.builder(itemBuilder: (context,index)=>TaskItem(),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}

