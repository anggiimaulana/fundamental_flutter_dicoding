import 'package:flutter/material.dart';
import 'package:shared_preferences_app/model/setting.dart';
import 'package:shared_preferences_app/services/shared_preferences_service.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final SharedPreferencesService _service;
  SharedPreferencesProvider(this._service);

  String _message = "";
  String get message => _message;

  Setting? _setting;
  Setting? get setting => _setting;

  Future<void> saveSettingValue(Setting value) async {
    try {
      await _service.saveSettingValue(value);
      _message = "Your setting has been saved successfully!";
    } catch (e) {
      _message = "Shared Preferences Error: $e";
    }
    notifyListeners();
  }

  void getSettingValue() async {
    try {
      _setting = _service.getSettingValue();
      _message = "Data Sucessfully Fetched";
    } catch (e) {
      _message = "Shared Preferences Error: $e";
    }
    notifyListeners();
  }
}
