class Settings {
  String backgroundColourHex;
  String dateColourHex;
  String timeColourHex;
  bool is24Hr;
  bool showDate;
  bool showSeconds;
  bool isMoving;
  String customDateFormat;
  String customTimeFormat;

  Settings({
    this.backgroundColourHex,
    this.dateColourHex,
    this.timeColourHex,
    this.is24Hr,
    this.showDate,
    this.showSeconds,
    this.isMoving,
    this.customDateFormat,
    this.customTimeFormat,
  });

  Settings.example() {
    backgroundColourHex = '000000';
    dateColourHex = 'FFFFFF';
    timeColourHex = 'FFFFFF';
    is24Hr = true;
    showDate = true;
    showSeconds = false;
    isMoving = false;
    customDateFormat = '';
    customTimeFormat = '';
  }

  Settings.fromMap(Map<String, dynamic> map) {
    this.backgroundColourHex = map['backgroundColourHex'];
    this.dateColourHex = map['dateColourHex'];
    this.timeColourHex = map['timeColourHex'];
    this.is24Hr = map['is24Hr'] == 1;
    this.showDate = map['showDate'] == 1;
    this.showSeconds = map['showSeconds'] == 1;
    this.isMoving = map['isMoving'] == 1;
    this.customDateFormat = map['customDateFormat'];
    this.customTimeFormat = map['customTimeFormat'];
  }

  Map<String, dynamic> toMap() {
    return {
      'backgroundColourHex': backgroundColourHex,
      'dateColourHex': dateColourHex,
      'timeColourHex': timeColourHex,
      'is24Hr': is24Hr ? 1 : 0,
      'showDate': showDate ? 1 : 0,
      'showSeconds': showSeconds ? 1 : 0,
      'isMoving': isMoving ? 1 : 0,
      'customDateFormat': customDateFormat,
      'customTimeFormat': customTimeFormat,
    };
  }

  Settings setSetting(String property, dynamic value) {
    Settings copy = this.clone();
    switch (property) {
      case 'backgroundColourHex':
        copy.backgroundColourHex = value;
        break;
      case 'dateColourHex':
        copy.dateColourHex = value;
        break;
      case 'timeColourHex':
        copy.timeColourHex = value;
        break;
      case 'is24Hr':
        copy.is24Hr = value;
        break;
      case 'showDate':
        copy.showDate = value;
        break;
      case 'showSeconds':
        copy.showSeconds = value;
        break;
      case 'isMoving':
        copy.isMoving = value;
        break;
      case 'customDateFormat':
        copy.customDateFormat = value;
        break;
      case 'customTimeFormat':
        copy.customTimeFormat = value;
        break;
    }
    return copy;
  }

  Settings clone() {
    return Settings(
      backgroundColourHex: this.backgroundColourHex,
      dateColourHex: this.dateColourHex,
      timeColourHex: this.timeColourHex,
      is24Hr: this.is24Hr,
      showDate: this.showDate,
      showSeconds: this.showSeconds,
      isMoving: this.isMoving,
      customDateFormat: this.customDateFormat,
      customTimeFormat: this.customTimeFormat,
    );
  }
}
