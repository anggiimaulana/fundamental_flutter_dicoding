import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_app/model/setting.dart';
import 'package:shared_preferences_app/utils/page_size_number.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;
  SharedPreferencesService(this._preferences);

  static const String _keyNotification = 'MY_NOTIFICATION';
  static const String _keyPageNumber = 'MY_PAGE_NUMBER';
  static const String _keySignature = 'MY_SIGNATURE';

  Future<void> saveSettingValue(Setting setting) async {
    try {
      await _preferences.setBool(_keyNotification, setting.notificationEnable);
      await _preferences.setInt(_keyPageNumber, setting.pageNumber);
      await _preferences.setString(_keySignature, setting.signature);
    } catch (e) {
      throw Exception("Shared Preferences Error: $e");
    }
  }

  Setting getSettingValue() {
    return Setting(
      notificationEnable: _preferences.getBool(_keyNotification) ?? true,
      pageNumber: _preferences.getInt(_keyPageNumber) ?? defaultPageSizeNumbers,
      signature: _preferences.getString(_keySignature) ?? "",
    );
  }
}
