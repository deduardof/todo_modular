import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_modular/src/app_module.dart';
import 'package:todo_modular/src/core/colors/app_colors.dart';
import 'package:todo_modular/src/core/themes/app_bar_theme.dart';
import 'package:todo_modular/src/core/themes/float_action_button_theme.dart';
import 'package:todo_modular/src/core/themes/input_decoration_theme.dart';
import 'package:todo_modular/src/core/themes/text_theme.dart';

void main() {
  runApp(
    ModularApp(module: AppModule(), child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      title: 'ToDo Modular',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF074041),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: textTheme,
        appBarTheme: appBarTheme,
        inputDecorationTheme: inputDecorationTheme,
        floatingActionButtonTheme: floatActionButtonTheme,
      ),
      routerConfig: Modular.routerConfig,
    );
  }
}
