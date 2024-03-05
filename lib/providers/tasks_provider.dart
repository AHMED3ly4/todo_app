import 'package:flutter/material.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/models/task_model.dart';

class TasksProvider with ChangeNotifier{
  List<TaskModel> tasks=[];

  DateTime date=DateTime.now();

  void getTasks()async{
    final allTasks = await FirebaseUtils.getAllTasksFromFireStore();
    tasks = allTasks.where((task) =>
        task.dateTime.day == date.day &&
        task.dateTime.month == date.month &&
        task.dateTime.year == date.year).toList();
    tasks.sort((task , nextTask) => task.dateTime.compareTo(nextTask.dateTime),);
    notifyListeners();
  }

  void changeDate(DateTime dateToChange){
    date=dateToChange;
    getTasks();
    notifyListeners();
  }

}