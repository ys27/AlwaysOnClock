class Settings {
  String backgroundcolorHex;
  String datecolorHex;
  String timecolorHex;
  bool is24Hr;
  bool showDate;
  bool showSeconds;
  bool isMoving;
  String customDateFormat;
  String customTimeFormat;

  Settings({
    this.backgroundcolorHex,
    this.datecolorHex,
    this.timecolorHex,
    this.is24Hr,
    this.showDate,
    this.showSeconds,
    this.isMoving,
    this.customDateFormat,
    this.customTimeFormat,
  });

  Settings.example() {
    backgroundcolorHex = '000000';
    datecolorHex = 'FFFFFF';
    timecolorHex = 'FFFFFF';
    is24Hr = true;
    showDate = true;
    showSeconds = false;
    isMoving = false;
    customDateFormat = '';
    customTimeFormat = '';
  }

  Settings.fromMap(Map<String, dynamic> map) {
    this.backgroundcolorHex = map['backgroundcolorHex'];
    this.datecolorHex = map['datecolorHex'];
    this.timecolorHex = map['timecolorHex'];
    this.is24Hr = map['is24Hr'] == 1;
    this.showDate = map['showDate'] == 1;
    this.showSeconds = map['showSeconds'] == 1;
    this.isMoving = map['isMoving'] == 1;
    this.customDateFormat = map['customDateFormat'];
    this.customTimeFormat = map['customTimeFormat'];
  }

  Map<String, dynamic> toMap() {
    return {
      'backgroundcolorHex': backgroundcolorHex,
      'datecolorHex': datecolorHex,
      'timecolorHex': timecolorHex,
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
      case 'backgroundcolorHex':
        copy.backgroundcolorHex = value;
        break;
      case 'datecolorHex':
        copy.datecolorHex = value;
        break;
      case 'timecolorHex':
        copy.timecolorHex = value;
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
      backgroundcolorHex: this.backgroundcolorHex,
      datecolorHex: this.datecolorHex,
      timecolorHex: this.timecolorHex,
      is24Hr: this.is24Hr,
      showDate: this.showDate,
      showSeconds: this.showSeconds,
      isMoving: this.isMoving,
      customDateFormat: this.customDateFormat,
      customTimeFormat: this.customTimeFormat,
    );
  }
}
