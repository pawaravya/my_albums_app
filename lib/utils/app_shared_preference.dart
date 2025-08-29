import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static final AppSharedPreferences customSharedPreferences = AppSharedPreferences._internal();
  SharedPreferences? _prefs;

  AppSharedPreferences._internal();

  Future<void> initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> saveValue<T>(String key, T value) async {
    if (_prefs == null) throw Exception('SharedPreferences not initialized');

    if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is List<String>) {
      await _prefs!.setStringList(key, value);
    } else {
      throw Exception('Unsupported value type');
    }
  }

  T? getValue<T>(String key) {
    if (_prefs == null) throw Exception('SharedPreferences not initialized');

    if (T == String) {
      return _prefs!.getString(key) as T?;
    } else if (T == List<String>) {
      return _prefs!.getStringList(key) as T?;
    } else {
      throw Exception('Unsupported value type');
    }
  }

  Future<void> removeValue(String key) async {
    if (_prefs == null) throw Exception('SharedPreferences not initialized');
    await _prefs!.remove(key);
  }

  Future<void> clearSharedPreference() async {
    if (_prefs == null) throw Exception('SharedPreferences not initialized');
    await _prefs!.clear();
  }
}
