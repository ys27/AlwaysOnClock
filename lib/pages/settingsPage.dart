import 'package:AlwaysOnClock/models/settings.dart';
import 'package:AlwaysOnClock/pages/clockPage.dart';
import 'package:AlwaysOnClock/services/database.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  Settings _settings;

  @override
  void initState() {
    super.initState();
    retrieveNewData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Always on Clock: Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ClockPage(
                    settings: _settings,
                  );
                },
              );
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                if (_settings != null) ...[
                  Text('colours - background, time'),
                  // Text('fonts'),
                  Text('24hr'),
                  Text('show date'),
                  Text('show seconds'),
                  Text('brightness'),
                  Text('static or moving'),
                  Text('custom date format, YYYY/MM/DD'),
                  Text('custom time format, HH:MM'),
                ]
              ],
            )),
      ),
    );
  }

  void retrieveNewData() async {
    Settings settings = await LocalDB().getSettings();

    setState(() => _settings = settings);
  }
}
