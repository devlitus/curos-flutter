import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mesajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mesajesStreamController.stream;

  initNotification() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print('token $token');
//      fuHeBtUUTr8:APA91bH1LTmF0Ji68lBAIBSMS197QJnaKxA4t1Cwkf79qWeaLfonKl8dqv5gtNYs1ptLzwFr0qQdxmYUVN5YgIhUZ2qOqCHoALH7EeTq1XOzoj11mpqFei0CCS3dD7WQvZG_Rl6CAh1l
    });
    _firebaseMessaging.configure(onMessage: (info) async {
      print('====== On Message =====');
      print(info);
      String argumentos = 'no-data';
      if (Platform.isAndroid) {
        argumentos = info['data']['comida'] ?? 'no-data';
      }
      _mesajesStreamController.sink.add(argumentos);
    }, onLaunch: (info) async {
      print('====== On Launch =====');
      print(info);
    }, onResume: (info) async {
      print('====== On Resume =====');
      print(info);
      final noti = info['data']['comida'];
//      _mesajesStreamController.sink.add(noti);
    });
  }
  dispose() {
    _mesajesStreamController?.close();
  }
}
