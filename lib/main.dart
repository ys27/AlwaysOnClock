import 'package:AlwaysOnClock/pages/settingsPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Always on Clock',
      theme: ThemeData(
        primaryColor: Colors.red[900],
        accentColor: Colors.blueGrey,
        fontFamily: 'Andika',
        backgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SettingsPage(),
    );
  }
}
