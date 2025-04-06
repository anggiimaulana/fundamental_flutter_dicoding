import 'package:app_sqlite/model/profile.dart';
import 'package:app_sqlite/services/sqlite_services.dart';
import 'package:flutter/material.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final SqliteServices _services;
  LocalDatabaseProvider(this._services);

  String _message = "";
  String get message => _message;

  List<Profile>? _profileList;
  List<Profile>? get profileList => _profileList;

  Profile? _profile;
  Profile? get profile => _profile;

  // fungsi untuk menyimpan data profil
  Future<void> saveProfileValue(Profile value) async {
    try {
      final result = await _services.insertItem(value);

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save data to local database";
        notifyListeners();
      } else {
        _message = "Success to save data to local database";
        notifyListeners();
      }
    } catch (e) {
      _message = "Failed to save data to local database";
      notifyListeners();
    }
  }

  // fungsi untuk memuat keseluruhan data profile
  Future<void> loadAllProfileValue() async {
    try {
      _profileList = await _services.getAllItems();
      _message = "All data has been loaded from local database";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load data from local database";
      notifyListeners();
    }
  }

  // fungsi untuk memuat data profile berdasarkan id
  Future<void> loadProfileValueById(int id) async {
    try {
      _profile = await _services.getItemById(id);
      _message = "Data has been loaded from local database";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load data from local database";
      notifyListeners();
    }
  }

  // fungsi untuk memperbarui data profile berdasarkan id
  Future<void> updateProfileValueById(int id, Profile value) async {
    try {
      final result = await _services.updateItem(id, value);

      final isEmptyRowUpdated = result == 0;
      if (isEmptyRowUpdated) {
        _message = "Failed to update data to local database";
        notifyListeners();
      } else {
        _message = "Success to update data to local database";
        notifyListeners();
      }
    } catch (e) {
      _message = "Failed to update data to local database";
      notifyListeners();
    }
  }

  // fungsi untuk menghapus data profile berdasarkan id
  Future<void> removeProfileValueById(int id) async {
    try {
      await _services.removeItem(id);
      _message = "Success to remove data from local database";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove data from local database";
      notifyListeners();
    }
  }
}
