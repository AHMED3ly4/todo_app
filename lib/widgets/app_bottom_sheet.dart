import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({super.key});


  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final dateFormat =DateFormat('dd/MM/yyyy');
    final timeFormat =DateFormat('Hm');
    var now=DateTime.now();
    DateTime selectedDate=DateTime.now();
    TimeOfDay selectedTime=TimeOfDay.now();
    return Container(
      height: MediaQuery.of(context).size.height *0.8,
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'ADD NEW TASK',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Enter your task'
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Add description',
              ),
              maxLines: 6,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                  vertical: 10
              ),
              child: Text(
                'Select Date',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
            ),
            GestureDetector(
              onTap: ()async{
                final selected= await showDatePicker(
                  context: context,
                  initialDate: now,
                  firstDate: now,
                  lastDate: now.add(const Duration(days: 365),),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                );
                selected != null ? selectedDate =selected :null;
                setState(() {

                });
              },
              child: Text(
                dateFormat.format(selectedDate),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 18
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                vertical: 10
              ),
              child: Text(
                'Select Time',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
            ),
            GestureDetector(
              onTap: ()async{
                final selected = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                );
                selected != null? selectedTime=selected:null;
                setState(() {

                });
              },
              child: Text(
                selectedTime.format(context),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 18
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
