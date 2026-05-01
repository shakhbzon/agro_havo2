import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:timezone/timezone.dart" as tz;
import "package:timezone/data/latest.dart" as tz_data;

class NotificationService {
    static final NotificationService _instance = NotificationService._internal();
    factory NotificationService() => _instance;
    NotificationService._internal();

    final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

    Future<void> init() async {
          tz_data.initializeTimeZones();
          const AndroidInitializationSettings androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
          const InitializationSettings initSettings = InitializationSettings(android: androidSettings);
          await _notificationsPlugin.initialize(initSettings);
    }

    Future<void> scheduleNotification({
          required int id,
          required String title,
          required String body,
          required DateTime scheduledDate,
    }) async {
          await _notificationsPlugin.zonedSchedule(
                  id,
                  title,
                  body,
                  tz.TZDateTime.from(scheduledDate, tz.local),
                  const NotificationDetails(
                            android: AndroidNotificationDetails(
                                        "agro_havo_channel",
                                        "Agro Havo Eslatmalari",
                                        importance: Importance.max,
                                        priority: Priority.high,
                                      ),
                          ),
                  uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
                  androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
                );
    }
}

}
