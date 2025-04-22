import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/setting/setting.dart';
import 'package:restaurant_app/provider/local/shared_preferences_provider.dart';
import 'package:restaurant_app/provider/setting/notification_state_provider.dart';
import 'package:restaurant_app/screen/setting/save_button_widget.dart';
import 'package:restaurant_app/screen/setting/theme_field_widget.dart';
import 'package:restaurant_app/style/colors/restaurant_color.dart';
import 'package:restaurant_app/utils/notification_state.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final notificationStateProvider = context.read<NotificationStateProvider>();
    final sharedPreferencesProvider = context.read<SharedPreferencesProvider>();

    Future.microtask(() async {
      sharedPreferencesProvider.getSettingValue();
      final setting = sharedPreferencesProvider.setting;
      if (setting != null) {
        notificationStateProvider.notificationState =
            setting.themeMode
                ? NotificationState.enable
                : NotificationState.disable;
      }
    });
  }

  void saveAction() async {
    final themeState =
        context.read<NotificationStateProvider>().notificationState;
    final isThemeEnable = themeState.isEnable;
    final Setting setting = Setting(themeMode: isThemeEnable);

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final sharedPreferencesProvider = context.read<SharedPreferencesProvider>();
    await sharedPreferencesProvider.saveSettingValue(setting);

    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text(sharedPreferencesProvider.message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Setting",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: Colors.white),
        ),
        backgroundColor: RestaurantColor.blue.color,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ThemeFieldWidget(),
              SaveButton(onPressed: () => saveAction()),
            ],
          ),
        ),
      ),
    );
  }
}
