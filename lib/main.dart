import 'package:flutter/material.dart';
import 'screens/waiting.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mc4geek_server_status/components/translations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WaitingScreen(),
      theme: ThemeData.dark().copyWith(accentColor: Colors.grey),
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('pl', ''),
      ],
    );
  }
}
