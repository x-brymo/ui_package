import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';

class NotificationInfo {
  const NotificationInfo({
    required this.appState,
    required this.firebaseMessage,
  });

  /// The app state when the notification was received.
  final AppState appState;

  /// The firebase notification object.
  final RemoteMessage firebaseMessage;

  /// The payload of the notification.
  Map<String, dynamic> get payload => firebaseMessage.data;
}
