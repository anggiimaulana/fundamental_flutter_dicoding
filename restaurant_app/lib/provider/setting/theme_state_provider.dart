import 'package:flutter/foundation.dart';
import 'package:restaurant_app/utils/theme_state.dart';

class ThemeStateProvider extends ChangeNotifier {
  ThemeState _themeState = ThemeState.lightTheme;

  ThemeState get notificationState => _themeState;

  set notificationState(ThemeState value) {
    _themeState = value;
    notifyListeners();
  }
}
