import 'package:flutter/material.dart';
import 'package:tourism_app/data/local/local_database_service.dart';
import 'package:tourism_app/data/model/tourism.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _services;
  LocalDatabaseProvider(this._services);

  String _message = "";
  String get message => _message;

  List<Tourism>? _tourismList;
  List<Tourism>? get tourismList => _tourismList;

  Tourism? _tourism;
  Tourism? get tourism => _tourism;

  Future<void> saveTourism(Tourism value) async {
    try {
      final result = await _services.insertItem(value);
      final isError = result == 0;

      if (isError) {
        _message = "Failed to save tourism";
      } else {
        _message = "Success to save tourism";
      }
    } catch (e) {
      _message = "Failed to save tourism";
    }
    notifyListeners();
  }

  Future<void> loadlAllTourism() async {
    try {
      _tourismList = await _services.getAllItems();
      _tourism = null;
      _message = "All of your data  is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your all data";
      notifyListeners();
    }
  }

  Future<void> loadTourismById(int id) async {
    try {
      _tourism = await _services.getItemById(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your data";
      notifyListeners();
    }
  }

  Future<void> removeTourismById(int id) async {
    try {
      await _services.removeItem(id);
      _message = "Your data is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }

  bool checkItemBookmark(int id) {
    if(_tourism == null) return false;
    return _tourism!.id == id;
  }
}
