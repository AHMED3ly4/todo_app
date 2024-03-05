import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/widgets/select_date.dart';

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({super.key});

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  DateTime selectedDate = DateTime.now();
  final  taskNameController=TextEditingController();
  final taskDescController=TextEditingController();
  final dateFormat = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'ADD NEW TASK',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Enter your task'),
              controller: taskNameController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Add description',
              ),
              controller: taskDescController,
              maxLines: 6,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Select Date',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
            ),
            SelectDate(
                onTab: () async {
              final selected = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: now,
                lastDate: now.add(
                  const Duration(days: 365),
                ),
                initialEntryMode: DatePickerEntryMode.calendarOnly,
              );
              selected != null ? selectedDate = selected : null;
              setState(() {});
            },
              text: dateFormat.format(selectedDate),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseUtils.addTaskToFireBase(TaskModel(
                    title: taskNameController.text,
                    description: taskDescController.text,
                    dateTime: selectedDate,
                ),
                ).timeout(
                  const Duration(seconds: 1),
                  onTimeout: () {
                    Provider.of<TasksProvider>(context,listen: false).getTasks();
                    Navigator.of(context).pop(context);
                  },
                ).catchError((_){
                  Fluttertoast.showToast(
                      msg: "OPS! something went wrong.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                });
              },
              child: const Text('ADD TASK'),
            ),
          ],
        ),
      ),
    );
  }
}
