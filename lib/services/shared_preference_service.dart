import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static setLoginUserEmail(String key, String value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    await preference.setString(key, value);
  }

  static getLoginUserEmail(String key) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(key);
  }

  static setUserLogin(String key, bool value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    await preference.setBool(key, value);
  }

  static checkUserLogin(String key) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getBool(key);
  }
}
