import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/screens/edit_task_screen.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/tabs/list_tab.dart';
import 'package:todo_app/tabs/setting_tab.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'providers/setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx)=> SettingProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx)=> TasksProvider()..getTasks(),
          ),
        ],
      child: TodoApp(),
    )

  );
}

class TodoApp extends StatefulWidget {

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider =Provider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),
        ListTab.routeName : (context) => ListTab(),
        SettingTab.routeName : (context) => SettingTab(),
        EditTaskScreen.routeName : (context) => EditTaskScreen(),
      },
      theme: AppTheme.appLightTheme,
      localizationsDelegates:AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // arabic
      ],
      locale: Locale(settingProvider.appLanguage),
    );
  }
}
