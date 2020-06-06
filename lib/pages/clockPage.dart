import 'dart:async';
import 'package:intl/intl.dart';
import 'package:AlwaysOnClock/models/settings.dart';
import 'package:AlwaysOnClock/shared/HexColor.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class ClockPage extends StatefulWidget {
  final Settings settings;

  ClockPage({this.settings});

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  Timer timer;
  bool _appBarVisible = true;
  String _currentDate;
  String _currentTime;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) => _getDateAndTime());
    Wakelock.enable();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    timer.cancel();
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(
        () => _appBarVisible = !_appBarVisible,
      ),
      child: Scaffold(
        backgroundColor: HexColor(widget.settings.backgroundColourHex),
        appBar: _appBarVisible ? AppBar() : null,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                _currentDate ?? '',
                style: TextStyle(
                  color: HexColor(widget.settings.dateColourHex),
                  fontSize: MediaQuery.of(context).size.width /
                      removeSymbols(_currentDate).length,
                ),
              ),
              Text(
                _currentTime ?? '',
                style: TextStyle(
                    color: HexColor(widget.settings.timeColourHex),
                    fontSize: MediaQuery.of(context).size.width /
                        removeSymbols(_currentTime).length),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getDateAndTime() {
    final DateTime now = DateTime.now();
    final String date = formatDate(now);
    final String time = formatTime(now);

    setState(() {
      _currentDate = date;
      _currentTime = time;
    });
  }

  String formatDate(DateTime datetime) {
    String format = widget.settings.customDateFormat == ''
        ? 'EEE, MMM d'
        : widget.settings.customDateFormat;
    return DateFormat(format).format(datetime);
  }

  String formatTime(DateTime datetime) {
    String format = widget.settings.customTimeFormat == ''
        ? 'hh:mm aaa'
        : widget.settings.customTimeFormat;
    return DateFormat(format).format(datetime);
  }

  String removeSymbols(String str) {
    return str.replaceAll(RegExp(r'[\\~#%&*{}/:<>?|\"-\s]'), '');
  }
}
