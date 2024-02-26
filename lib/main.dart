import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/tabs/list_tab.dart';
import 'package:todo_app/tabs/setting_tab.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
        create: (ctx)=> SettingProvider(),
      child: TodoApp(),
    ),
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
