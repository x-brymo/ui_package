import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveData(String key, dynamic value) async {
    if (_prefs == null) {
      await initialize();
    }

    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    }
  }

  static dynamic loadData(String key) {
    if (_prefs == null) {
      return null; // You might want to handle this case differently based on your requirements
    }

    return _prefs.get(key);
  }
  static Future<String?> getData(String key) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key);
  }
  static Future<void> removeData(String key) async {
    if (_prefs == null) {
      await initialize();
    }

    await _prefs.remove(key);
  }
}
