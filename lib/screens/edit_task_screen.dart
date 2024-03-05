import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/widgets/myTextFormField.dart';
import 'package:todo_app/widgets/select_date.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTaskScreen extends StatefulWidget {
static String routeName='edit task screen';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final dateFormat = DateFormat('dd/MM/yyyy');
  DateTime? selectedDate;
  final titleController =TextEditingController();
  final descriptionController =TextEditingController();
    @override
  Widget build(BuildContext context) {
    final taskToEdit=ModalRoute.of(context)!.settings.arguments as TaskModel;
    selectedDate ==null? selectedDate =taskToEdit.dateTime:null;
    titleController.text.isEmpty ? titleController.text= taskToEdit.title: null;
    descriptionController.text.isEmpty ? descriptionController.text= taskToEdit.description: null;

    double screenHeight =MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 25
          ),
          child: Text(AppLocalizations.of(context)!.toDoList,
          ),
        ),
      ),
      body: SizedBox(
        height: screenHeight,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: screenHeight*0.22,
              color: AppTheme.blue,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(height: screenHeight*0.15,),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    height: screenHeight*0.75,
                    child: Column(
                      children: [
                        MyTextFormField(
                          hintText: 'Title',
                          controller: titleController,
                        ),
                        const SizedBox(height: 20,),
                        MyTextFormField(
                          hintText: 'Description',
                          controller: descriptionController,
                          maxLines: 6,
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Select Date',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SelectDate(
                            onTab: ()async{
                              DateTime ? datePickerSelect = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                initialEntryMode: DatePickerEntryMode.calendarOnly,
                                initialDate: selectedDate
                              );
                              selectedDate = datePickerSelect ?? DateTime.now();
                            },
                            text: dateFormat.format(selectedDate!),
                        ),
                        const Spacer(),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(50),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.blue,
                              foregroundColor: AppTheme.white
                            ),
                            onPressed: (){
                              FirebaseUtils.editTaskData(
                                  taskToEdit.id,
                                  titleController.text,
                                  descriptionController.text,
                                  selectedDate!,
                              ).timeout(
                                const Duration(seconds: 1),
                                onTimeout: (){
                                  Provider.of<TasksProvider>(context,listen: false).getTasks();
                                  Navigator.of(context).pop();
                                },
                              ).catchError(
                                  (_){
                                    Fluttertoast.showToast(
                                        msg: "OPS! something went wrong.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    Navigator.of(context).pop();
                                  }

                              );
                            },
                            child:  Text('EDIT TASK',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 18,
                              color: AppTheme.white,
                            ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
