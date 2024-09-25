import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;
class CashHelper  {
  static SharedPreferences? _prefs;
  // link chatGPT: https://chatgpt.com/share/daaac3df-3be2-47b4-8c09-468ab5fb367a
  // CREATE ; by Mahmoud Hafez
  // Initialize SharedPreferences instance
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  // create instance
  static CashHelper instance = CashHelper();
  // Save a simple key-value pair (e.g., String, int, bool)
   Future<bool> saveData({required String key, required dynamic value}) async {
    if (_prefs == null) await init();

    if (value is String) {
      return await _prefs!.setString(key, value);
    } else if (value is int) {
      return await _prefs!.setInt(key, value);
    } else if (value is bool) {
      return await _prefs!.setBool(key, value);
    } else if (value is double) {
      return await _prefs!.setDouble(key, value);
    } else {
      throw Exception("Invalid type");
    }
  }

  // Get a simple key-value pair (e.g., String, int, bool)
   dynamic getData({required String key}) {
    if (_prefs == null) throw Exception("CashHelper is not initialized");

    return _prefs!.get(key);
  }

  // Save a model as JSON
   Future<bool> saveModel({required String key, required Map<String, dynamic> model}) async {
    if (_prefs == null) await init();

    String jsonString = jsonEncode(model);
    return await _prefs!.setString(key, jsonString);
  }

  // Get a model from JSON
   Map<String, dynamic>? getModel({required String key}) {
    if (_prefs == null) throw Exception("CashHelper is not initialized");

    String? jsonString = _prefs!.getString(key);
    if (jsonString == null) return null;

    return jsonDecode(jsonString);
  }

  // Remove data
   Future<bool> removeData({required String key}) async {
    if (_prefs == null) await init();

    return await _prefs!.remove(key);
  }

  // Clear all data
   Future<bool> clearData() async {
    if (_prefs == null) await init();
    return await _prefs!.clear();
  }

   Future<bool> updateModelField({required String key, required String field, required dynamic value}) async {
  if (_prefs == null) await init();

  Map<String, dynamic>? model = getModel(key: key);
  if (model != null) {
    model[field] = value;
    return await saveModel(key: key, model: model);
  }
  return false;
}
 bool containsKey({required String key}) {
  if (_prefs == null) throw Exception("CashHelper is not initialized");

  return _prefs!.containsKey(key);
}
// حفظ قائمة من النماذج كـ JSON
 Future<bool> saveModelList({required String key, required List<Map<String, dynamic>> modelList}) async {
  if (_prefs == null) await init();

  String jsonString = jsonEncode(modelList);
  return await _prefs!.setString(key, jsonString);
}

// استرجاع قائمة من النماذج من JSON
 List<Map<String, dynamic>>? getModelList({required String key}) {
  if (_prefs == null) throw Exception("CashHelper is not initialized");

  String? jsonString = _prefs!.getString(key);
  if (jsonString == null) return null;

  return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
}
 Future<void> logEvent(String event) async {
  if (_prefs == null) await init();

  String? log = _prefs!.getString('logs') ?? '';
  log += '$event\n';
  await _prefs!.setString('logs', log);
}

 String? getLogs() {
  if (_prefs == null) throw Exception("CashHelper is not initialized");

  return _prefs!.getString('logs');
}

 Future<bool> clearLogs() async {
  if (_prefs == null) await init();

  return await _prefs!.remove('logs');
}
 Future<void> addToFavorites({required String key, required String item}) async {
  if (_prefs == null) await init();

  List<String> favorites = _prefs!.getStringList(key) ?? [];
  favorites.add(item);
  await _prefs!.setStringList(key, favorites);
}

 List<String>? getFavorites({required String key}) {
  if (_prefs == null) throw Exception("CashHelper is not initialized");

  return _prefs!.getStringList(key);
}

 Future<void> removeFromFavorites({required String key, required String item}) async {
  if (_prefs == null) await init();

  List<String> favorites = _prefs!.getStringList(key) ?? [];
  favorites.remove(item);
  await _prefs!.setStringList(key, favorites);
}
 Future<String> backupData() async {
  if (_prefs == null) await init();

  Map<String, dynamic> allData = _prefs!.getKeys().fold<Map<String, dynamic>>({}, (map, key) {
    map[key] = _prefs!.get(key);
    return map;
  });

  return jsonEncode(allData);
}

 Future<void> restoreData(String backup) async {
  if (_prefs == null) await init();

  Map<String, dynamic> data = jsonDecode(backup);
  data.forEach((key, value) async {
    if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is int) {
      await _prefs!.setInt(key, value);
    } else if (value is bool) {
      await _prefs!.setBool(key, value);
    } else if (value is double) {
      await _prefs!.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs!.setStringList(key, List<String>.from(value));
    }
  });
}
// حفظ الوقت الحالي
 Future<void> saveCurrentTime({required String key}) async {
  if (_prefs == null) await init();

  String currentTime = DateTime.now().toIso8601String();
  await _prefs!.setString(key, currentTime);
}

// استرجاع الوقت المحفوظ
 DateTime? getSavedTime({required String key}) {
  if (_prefs == null) throw Exception("CashHelper is not initialized");

  String? timeString = _prefs!.getString(key);
  return timeString != null ? DateTime.parse(timeString) : null;
}

// التحقق من مرور فترة زمنية معينة
 bool hasTimeElapsed({required String key, required Duration duration}) {
  DateTime? savedTime = getSavedTime(key: key);
  if (savedTime == null) return true;

  return DateTime.now().difference(savedTime) > duration;
}
// حفظ الوقت الحالي لحدث دوري
 Future<void> saveEventTime({required String key}) async {
  if (_prefs == null) await init();

  String currentTime = DateTime.now().toIso8601String();
  await _prefs!.setString(key, currentTime);
}

// التحقق من مرور دورة زمنية محددة
 bool isEventDue({required String key, required Duration cycle}) {
  DateTime? savedTime = getSavedTime(key: key);
  if (savedTime == null) return true;

  return DateTime.now().difference(savedTime) >= cycle;
}
// حفظ مجموعة من القيم دفعة واحدة
 Future<void> saveBatchData(Map<String, dynamic> data) async {
  if (_prefs == null) await init();

  data.forEach((key, value) async {
    await saveData(key: key, value: value);
  });
}

// استرجاع مجموعة من القيم دفعة واحدة
 Map<String, dynamic> getBatchData(List<String> keys) {
  if (_prefs == null) throw Exception("CashHelper is not initialized");

  Map<String, dynamic> data = {};
  for (String key in keys) {
    data[key] = getData(key: key);
  }
  return data;
}
// حفظ البيانات مع مدة انتهاء
 Future<void> cacheData({required String key, required dynamic value, required Duration duration}) async {
  if (_prefs == null) await init();

  await saveData(key: key, value: value);
  await saveCurrentTime(key: '$key-expiry');
}

// التحقق من انتهاء مدة البيانات المؤقتة
 bool isCacheExpired({required String key}) {
  return hasTimeElapsed(key: '$key-expiry', duration: Duration.zero);
}

// استرجاع البيانات المؤقتة فقط إذا لم تنته مدة صلاحيتها
 dynamic getCachedData({required String key}) {
  if (!isCacheExpired(key: key)) {
    return getData(key: key);
  }
  return null; // Return null if cache expired
}
// مزامنة البيانات مع قاعدة بيانات محلية
 Future<void> syncWithLocalDatabase(Map<String, dynamic> localData) async {
  // افترض أن لديك قاعدة بيانات محلية وتريد مزامنتها مع `SharedPreferences`
  localData.forEach((key, value) async {
    await saveData(key: key, value: value);
  });
}

// مزامنة البيانات مع سيرفر عن بعد
 Future<void> syncWithRemoteServer(Function fetchDataFromServer) async {
  // افترض أن `fetchDataFromServer` هي وظيفة تستدعي API لتحميل البيانات من سيرفر
  Map<String, dynamic> remoteData = await fetchDataFromServer();

  remoteData.forEach((key, value) async {
    await saveData(key: key, value: value);
  });
}
// تسجيل وظيفة لإشعار عند تحديث بيانات
 void onDataChange(String key, Function callback) {
  if (_prefs == null) throw Exception("CashHelper is not initialized");
    if (_prefs!.containsKey(key)) {
      callback();
    }
    _prefs!.setBool(key, true);
 
}

// حفظ تاريخ مهم
 Future<void> saveImportantDate({required String key, required DateTime date}) async {
  if (_prefs == null) await init();

  String dateString = date.toIso8601String();
  await saveData(key: key, value: dateString);
}

// استرجاع تاريخ مهم
 DateTime? getImportantDate({required String key}) {
  if (_prefs == null) throw Exception("CashHelper is not initialized");

  String? dateString = _prefs!.getString(key);
  return dateString != null ? DateTime.parse(dateString) : null;
}

// التحقق من اقتراب موعد حدث مهم
 bool isEventUpcoming({required String key, required Duration notificationDuration}) {
  DateTime? eventDate = getImportantDate(key: key);
  if (eventDate == null) return false;

  return eventDate.isBefore(DateTime.now().add(notificationDuration));
}


// مزامنة الوقت مع خادم خارجي
 Future<DateTime> syncTimeWithServer(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    String serverTimeString = json.decode(response.body)['datetime'];
    return DateTime.parse(serverTimeString);
  } else {
    throw Exception('Failed to sync time with server');
  }
}

// حفظ الوقت المزامن
 Future<void> saveSyncedTime(String key, String url) async {
  DateTime syncedTime = await syncTimeWithServer(url);
  await saveImportantDate(key: key, date: syncedTime);
}

// حفظ عدد المتابعين
 Future<void> saveFollowersCount({required String key, required int count}) async {
  if (_prefs == null) await init();

  await saveData(key: key, value: count);
}

// استرجاع عدد المتابعين
 int getFollowersCount({required String key, int defaultValue = 0}) {
  if (_prefs == null) throw Exception("CashHelper is not initialized");

  return getData(key: key) ?? defaultValue;
}

// زيادة عدد الإعجابات
 Future<void> incrementLikesCount({required String key}) async {
  int currentLikes = getData(key: key) ?? 0;
  await saveData(key: key, value: currentLikes + 1);
}

// حفظ بداية حدث مستمر
 Future<void> startContinuousEvent({required String key}) async {
  if (_prefs == null) await init();

  await saveCurrentTime(key: '$key-start');
}

// التحقق من مرور وقت محدد منذ بدء حدث
 bool hasTimePassedSinceStart({required String key, required Duration duration}) {
  return hasTimeElapsed(key: '$key-start', duration: duration);
}

// إنهاء حدث مستمر
 Future<void> endContinuousEvent({required String key}) async {
  if (_prefs == null) await init();

  await saveCurrentTime(key: '$key-end');
}

// التحقق من استمرار حدث
 bool isEventOngoing({required String key}) {
  return getSavedTime(key: '$key-end') == null;
}


}
