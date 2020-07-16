import 'package:flutter/material.dart';
import 'package:pushlocal/src/pages/home_page.dart';
import 'package:pushlocal/src/pages/message_page.dart';
import 'package:pushlocal/src/provider/push_notification_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    final pushNotification = PushNotificationProvider();
    pushNotification.initNotification();
    pushNotification.mensajes.listen((data) {
      navigatorKey.currentState.pushNamed('mensaje', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Push Local',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'mensaje': (BuildContext context) => MessagePage(),
      },
    );
  }
}
