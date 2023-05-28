import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// fjmPol29T2O1kWWHPFlXfl:APA91bFhtm4zTodeSrwyd2wWX0b9ct8zKzl1PJPqRit9wUrCX9eqashrxahVKJFDSDxTO1aw-5n1jMNLz12VMCzf8x_ZKLQjC-GCiggtmyjla76rD-AGtZ7ovIp9CATxhC-HLiEj3zrr
class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    //  print('onBackgroundHandler Handler ${message.messageId}');
    print(message.data);

    final argumento = message.data['comida'];
    print('$argumento');
    _messageStream.add(argumento);
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //print('onMessageHandler Handler ${message.messageId}');
    print(message.data);
    //_messageStream.add(message.notification?.body ?? 'No title');
    //_messageStream.add(message.data.toString() ?? 'No title');

    final argumento = message.data['comida'];
    print('$argumento');
    _messageStream.add(argumento);
  }

  static Future _onOpenMessageOpenApp(RemoteMessage message) async {
    //print('onOpenMessageOpenApp Handler ${message.messageId}');
    print(message.data);

    final argumento = message.data['comida'];
    print('$argumento');
    _messageStream.add(argumento);
  }

  static Future initializeApp() async {
    //push Notificacion
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    //local notification

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenMessageOpenApp);
  }

  static closeStreams() {
    _messageStream.close();
  }
}
