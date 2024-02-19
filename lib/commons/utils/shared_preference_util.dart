import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  // KEYS

  static const kUserName = "username";

  // METHODS

  static Future<String?> getString({
    required String key,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString(key);
  }

  static Future<void> setString({
    required String key,
    required String value,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(key, value);
  }

  static Future<void> removeString({required String key}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.remove(key);
  }
}
