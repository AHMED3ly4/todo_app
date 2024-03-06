import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/providers/setting_provider.dart';
import 'package:todo_app/providers/tasks_provider.dart';

import '../widgets/task_item.dart';

class ListTab extends StatelessWidget {
  static const String routeName = 'list tab';

  const ListTab({super.key});
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    SettingProvider settingProvider = Provider.of(context);
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
            weekDaySelectedColor: AppTheme.lightBlue,
            selectedBackgroundColor: AppTheme.lightBlue,
            disableDaysBeforeNow: true,
          ),
          headerOptions: HeaderOptions(
            weekDayStringType: WeekDayStringTypes.SHORT,
            monthStringType: MonthStringTypes.FULL,
            backgroundColor: AppTheme.lightBlue,
            headerTextColor: Colors.black,
          ),
          dateTime: CalendarDateTime(year: tasksProvider.date.year,
            month: tasksProvider.date.month,
            day: tasksProvider.date.day,
          ),
          onChangeDateTime: (calenderDateTime) {
            tasksProvider.changeDate(calenderDateTime.toDateTime());
          },
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) =>
                TaskItem(tasksProvider.tasks[index]),
            itemCount: tasksProvider.tasks.length,
          ),
        ),
      ],
    );
  }
}
