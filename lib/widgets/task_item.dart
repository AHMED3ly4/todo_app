import 'package:flutter/material.dart';

import '../app_theme.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      height: 115,
      padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20
      ),
      decoration: BoxDecoration(
          color:Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 4,
            color: AppTheme.blue,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Play basketball',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: AppTheme.blue
                ),
              ),
              Text('12:00 AM',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 34,
            width: 69,
            decoration: BoxDecoration(
                color:AppTheme.blue,
                borderRadius: BorderRadius.circular(10)
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 38,
            ),
          ),
        ],
      ),
    );
  }
}
