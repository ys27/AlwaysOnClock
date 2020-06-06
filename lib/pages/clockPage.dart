import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  Timer timer;
  bool _appBarVisible = true;
  String _currentDateTime = DateTime.now().toString();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) => _getTime());
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
    return Scaffold(
      appBar: _appBarVisible ? AppBar() : null,
      body: GestureDetector(
        onTap: () => setState(
          () => _appBarVisible = !_appBarVisible,
        ),
        child: Container(
          child: Text(_currentDateTime),
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    setState(() {
      _currentDateTime = now.toString();
    });
  }
}
