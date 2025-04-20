import 'package:flutter/widgets.dart';
import 'package:notification_app/services/local_notification_service.dart';

class LocalNotificationProvide extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvide(this.flutterNotificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  Future<bool> requestPermission() async {
    _permission = await flutterNotificationService.requestPermission();
    notifyListeners();
    return _permission ?? false;
  }

  void showNotification() {
    _notificationId += 1;
    flutterNotificationService.showNotification(
      id: _notificationId,
      title: "New Notification",
      body: "This is a new notification with id $_notificationId",
      payload: "This is a payload from notification with id $_notificationId",
    );
  }
}
