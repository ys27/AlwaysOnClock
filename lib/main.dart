import 'package:AlwaysOnClock/models/settings.dart';
import 'package:AlwaysOnClock/pages/settingsPage.dart';
import 'package:AlwaysOnClock/services/database.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Settings _settings;

  @override
  void initState() {
    super.initState();
    retrieveNewData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Always on Clock',
        theme: ThemeData(
          primaryColor: Colors.red[900],
          accentColor: Colors.blueGrey,
          fontFamily: 'Andika',
          backgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _settings != null
            ? SettingsPage(
                settings: _settings,
                retrieveData: retrieveNewData,
              )
            : Container(),
      ),
    );
  }

  void retrieveNewData() async {
    Settings settings = await LocalDB().getSettings();
    setState(() => _settings = settings);
  }
}
