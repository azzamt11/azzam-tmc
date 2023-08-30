import 'package:shared_preferences/shared_preferences.dart';

class DataFunctions {

  String _generateKey(String userId, String key) {
    return '$userId/$key';
  }

  Future<void> saveString(String userId, String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_generateKey(userId, key), value);
  }

  Future<String?> getString(String userId, String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_generateKey(userId, key));
  }

}