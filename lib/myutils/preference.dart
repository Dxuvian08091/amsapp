import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static SharedPreferences? _prefs;
  static final Map<String, dynamic> _memoryPrefs = <String, dynamic>{};

  static Future load() async => _prefs = await SharedPreferences.getInstance();

  static void setString(String key, String value) {
    _prefs!.setString(key, value);
    _memoryPrefs[key] = value;
  }

  static void setInt(String key, int value) {
    _prefs!.setInt(key, value);
    _memoryPrefs[key] = value;
  }

  static void setDouble(String key, double value) {
    _prefs!.setDouble(key, value);
    _memoryPrefs[key] = value;
  }

  static void setBool(String key, bool value) {
    _prefs!.setBool(key, value);
    _memoryPrefs[key] = value;
  }

  static String getString(String key, {String def = ""}) {
    String val = "";
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val.isEmpty) {
      val = _prefs!.getString(key) ?? "";
    }
    if (val.isEmpty) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static int getInt(String key, {int def = -1}) {
    int val = -1;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val < 0) {
      val = _prefs!.getInt(key) ?? -1;
    }
    if (val < 0) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static double getDouble(String key, {double def = -1}) {
    double val = -1;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val < 0) {
      val = _prefs!.getDouble(key) ?? -1;
    }
    if (val < 0) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static bool getBool(String key, {bool def = false}) {
    bool? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    val ??= _prefs!.getBool(key);
    if (val == null) {
      _memoryPrefs[key] = def;
      return def;
    }
    return val;
  }

  static void clear() {
    _prefs!.clear();
  }
}
