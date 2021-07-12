import 'package:always_on_clock/models/settings.dart';
import 'package:always_on_clock/pages/clockPage.dart';
import 'package:always_on_clock/services/database.dart';
import 'package:always_on_clock/shared/HexColor.dart';
// import 'package:always_on_clock/shared/components.dart';
import 'package:always_on_clock/shared/styles.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:intl/intl.dart';

class SettingsPage extends StatefulWidget {
  final Settings settings;
  final Function retrieveData;

  SettingsPage({this.settings, this.retrieveData});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormatController = TextEditingController();
  final _timeFormatController = TextEditingController();

  // final FocusNode _dateFormatFocus = new FocusNode();
  // final FocusNode _timeFormatFocus = new FocusNode();

  // bool _isDateFormatInFocus = false;
  // bool _isTimeFormatInFocus = false;

  Color _backgroundcolor;
  Color _datecolor;
  Color _timecolor;
  bool _is24Hr;
  bool _showDate;
  bool _showSeconds;
  bool _isMoving;
  // String _customDateFormat;
  // String _customTimeFormat;

  @override
  void initState() {
    super.initState();
    _backgroundcolor = HexColor(widget.settings.backgroundcolorHex);
    _datecolor = HexColor(widget.settings.datecolorHex);
    _timecolor = HexColor(widget.settings.timecolorHex);
    _is24Hr = widget.settings.is24Hr;
    _showDate = widget.settings.showDate;
    _showSeconds = widget.settings.showSeconds;
    _isMoving = widget.settings.isMoving;
    // _customDateFormat = widget.settings.customDateFormat;
    // _customTimeFormat = widget.settings.customTimeFormat;

    _dateFormatController.text = widget.settings.customDateFormat;
    _timeFormatController.text = widget.settings.customTimeFormat;

    // _dateFormatFocus.addListener(_checkFocus);
    // _timeFormatFocus.addListener(_checkFocus);
  }

  // void _checkFocus() {
  //   setState(() {
  //     _isDateFormatInFocus = _dateFormatFocus.hasFocus;
  //     _isTimeFormatInFocus = _timeFormatFocus.hasFocus;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.settings != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Always on Clock'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ClockPage(
                      settings: widget.settings,
                    );
                  },
                );
              },
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: formPadding,
            children: <Widget>[
              // Text('fonts'),
              // Text('Only on at certain times - can I turn back on?'),
              SizedBox(height: 10.0),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      settingsText('Set background color'),
                      Icon(
                        Icons.brightness_1,
                        color: _backgroundcolor,
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  Color color = await showDialog(
                    context: context,
                    builder: (context) {
                      return colorPickerDialog(
                        context,
                        HexColor(widget.settings.backgroundcolorHex),
                        HexColor(Settings.example().backgroundcolorHex),
                      );
                    },
                  );
                  if (color != null) {
                    setState(() => _backgroundcolor = color);
                    await LocalDB().updateSettings(widget.settings.setSetting(
                        'backgroundcolorHex',
                        color.value.toRadixString(16).substring(2)));
                    widget.retrieveData();
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      settingsText('Set date color'),
                      Icon(
                        Icons.brightness_1,
                        color: _datecolor,
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  Color color = await showDialog(
                    context: context,
                    builder: (context) {
                      return colorPickerDialog(
                        context,
                        HexColor(widget.settings.datecolorHex),
                        HexColor(Settings.example().datecolorHex),
                      );
                    },
                  );
                  if (color != null) {
                    setState(() => _datecolor = color);
                    await LocalDB().updateSettings(widget.settings.setSetting(
                        'datecolorHex',
                        color.value.toRadixString(16).substring(2)));
                    widget.retrieveData();
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      settingsText('Set time color'),
                      Icon(
                        Icons.brightness_1,
                        color: _timecolor,
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  Color color = await showDialog(
                    context: context,
                    builder: (context) {
                      return colorPickerDialog(
                        context,
                        HexColor(widget.settings.timecolorHex),
                        HexColor(Settings.example().timecolorHex),
                      );
                    },
                  );
                  if (color != null) {
                    setState(() => _timecolor = color);
                    await LocalDB().updateSettings(widget.settings.setSetting(
                        'timecolorHex',
                        color.value.toRadixString(16).substring(2)));
                    widget.retrieveData();
                  }
                },
              ),
              SizedBox(height: 10.0),
              SwitchListTile(
                  title: settingsText('24-hour mode'),
                  value: _is24Hr,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  onChanged: (val) {
                    setState(() => _is24Hr = val);
                    LocalDB().updateSettings(
                        widget.settings.setSetting('is24Hr', val));
                    widget.retrieveData();
                  }),
              SizedBox(height: 10.0),
              SwitchListTile(
                  title: settingsText('Show date'),
                  value: _showDate,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  onChanged: (val) {
                    setState(() => _showDate = val);
                    LocalDB().updateSettings(
                        widget.settings.setSetting('showDate', val));
                    widget.retrieveData();
                  }),
              SizedBox(height: 10.0),
              SwitchListTile(
                  title: settingsText('Show seconds'),
                  value: _showSeconds,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  onChanged: (val) {
                    setState(() => _showSeconds = val);
                    LocalDB().updateSettings(
                        widget.settings.setSetting('showSeconds', val));
                    widget.retrieveData();
                  }),
              SizedBox(height: 10.0),
              SwitchListTile(
                  title: settingsText('Move date/time around'),
                  value: _isMoving,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  onChanged: (val) {
                    setState(() => _isMoving = val);
                    LocalDB().updateSettings(
                        widget.settings.setSetting('isMoving', val));
                    widget.retrieveData();
                  }),
              // SizedBox(height: 10.0),
              // TextFormField(
              //   controller: _dateFormatController,
              //   focusNode: _dateFormatFocus,
              //   validator: (val) {
              //     if (DateFormat(val).format(DateTime.now()) is! String) {
              //       return 'Enter a valid date format.';
              //     }
              //     return null;
              //   },
              //   decoration: clearInput(
              //     labelText: 'Custom Date Format',
              //     enabled: _customDateFormat.isNotEmpty && _isDateFormatInFocus,
              //     onPressed: () {
              //       setState(() => _customDateFormat = '');
              //       _dateFormatController.safeClear();
              //     },
              //   ),
              //   textCapitalization: TextCapitalization.words,
              //   onChanged: (val) {
              //     setState(() => _customDateFormat = val);
              //   },
              // ),
              // SizedBox(height: 10.0),
              // TextFormField(
              //   controller: _timeFormatController,
              //   focusNode: _timeFormatFocus,
              //   validator: (val) {
              //     if (DateFormat(val).format(DateTime.now()) is! String) {
              //       return 'Enter a valid time format.';
              //     }
              //     return null;
              //   },
              //   decoration: clearInput(
              //     labelText: 'Custom Time Format',
              //     enabled: _customTimeFormat.isNotEmpty && _isTimeFormatInFocus,
              //     onPressed: () {
              //       setState(() => _customTimeFormat = '');
              //       _timeFormatController.safeClear();
              //     },
              //   ),
              //   textCapitalization: TextCapitalization.words,
              //   onChanged: (val) {
              //     setState(() => _customTimeFormat = val);
              //   },
              // ),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}

// extension on TextEditingController {
//   void safeClear() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       this.clear();
//     });
//   }
// }

Widget colorPickerDialog(
    BuildContext context, Color currentColor, Color resetColor) {
  Color pickerColor;

  return Scaffold(
    appBar: AppBar(
      title: Text('Color Picker'),
    ),
    body: Container(
      padding: formPadding,
      child: ListView(
        children: <Widget>[
          ColorPicker(
            pickerColor: currentColor,
            onColorChanged: (val) => pickerColor = val,
            showLabel: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).accentColor),
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop(resetColor),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                ),
                child: Text(
                  'Select',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop(pickerColor),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget settingsText(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
  );
}
