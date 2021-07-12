import 'dart:async';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:always_on_clock/models/settings.dart';
import 'package:always_on_clock/shared/HexColor.dart';
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
  String _currentDate;
  String _currentTime;

  @override
  void initState() {
    super.initState();
    _getDateAndTime();
    timer = Timer.periodic(Duration(seconds: 1), (_) => _getDateAndTime());
    Wakelock.enable();
    SystemChrome.setEnabledSystemUIOverlays([]);
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
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => Navigator.of(context).pop()),
      child: Scaffold(
        backgroundColor: HexColor(widget.settings.backgroundcolorHex),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (_currentDate != null) ...[
                Text(
                  _currentDate,
                  style: TextStyle(
                    color: HexColor(widget.settings.datecolorHex),
                    fontSize: MediaQuery.of(context).size.width /
                        (removeSymbols(_currentDate).length + 4),
                  ),
                )
              ],
              if (_currentTime != null) ...[
                Text(
                  _currentTime,
                  style: TextStyle(
                    color: HexColor(widget.settings.timecolorHex),
                    fontSize: MediaQuery.of(context).size.width /
                        (removeSymbols(_currentTime).length),
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _getDateAndTime() {
    final DateTime now = DateTime.now();

    setState(() {
      _currentDate = formatDate(now);
      _currentTime = formatTime(now);
    });
  }

  String formatDate(DateTime datetime) {
    String format = (widget.settings.customDateFormat == ''
        ? 'EEE, MMM d'
        : widget.settings.customDateFormat);
    return widget.settings.showDate
        ? DateFormat(format).format(datetime)
        : null;
  }

  String formatTime(DateTime datetime) {
    String seconds = widget.settings.showSeconds ? ':ss' : '';
    String format = widget.settings.customTimeFormat == ''
        ? (widget.settings.is24Hr ? 'HH:mm$seconds' : 'h:mm$seconds aaa')
        : widget.settings.customTimeFormat;
    return DateFormat(format).format(datetime);
  }

  String removeSymbols(String str) {
    return str.replaceAll(RegExp(r'[\\~#%&*{}/:<>?|\"-\s]'), '');
  }
}
