import 'package:flutter/material.dart';
import 'package:preferenciausuarioapp/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciausuarioapp/src/widgets/menu_widget.dart';

class SettingPage extends StatefulWidget {
  static final String routeName = 'setting';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _colorSecundario;
  int _genero;
  String _nombre;
  TextEditingController _textEditingController;
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = SettingPage.routeName;
    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _textEditingController = new TextEditingController(text: prefs.nombre);
  }

  _setSelectedRadio(int value) {
    setState(() {
      prefs.genero = value;
      _genero = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ajustes'),
          backgroundColor: (prefs.colorSecundario ? Colors.teal :  Colors.blueAccent),
        ),
        drawer: MenuWidget(),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Setting',
                style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            SwitchListTile(
              value: _colorSecundario,
              title: Text('Color secundario'),
              onChanged: (value) {
                setState(() {
                  _colorSecundario = value;
                  prefs.colorSecundario = value;
                });
              },
            ),
            RadioListTile(
              value: 1,
              title: Text('Masculino'),
              groupValue: _genero,
              onChanged: _setSelectedRadio,
            ),
            RadioListTile(
              value: 2,
              title: Text('Femenino'),
              groupValue: _genero,
              onChanged: _setSelectedRadio,
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    labelText: 'Nombre', helperText: 'Nombre de la persona'),
                onChanged: (value) {
                  prefs.nombre = value;
                },
              ),
            )
          ],
        ));
  }
}
