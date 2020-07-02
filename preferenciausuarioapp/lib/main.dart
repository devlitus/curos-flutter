import 'package:flutter/material.dart';
import 'package:preferenciausuarioapp/src/pages/home_page.dart';
import 'package:preferenciausuarioapp/src/pages/setting_page.dart';
import 'package:preferenciausuarioapp/src/share_prefs/preferencias_usuario.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Preferencias',
      initialRoute: prefs.ultimaPagina,
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        SettingPage.routeName: (BuildContext context) => SettingPage()
      },
    );
  }
}
