import 'package:componentes/src/providers/menu_provaider.dart';
import 'package:flutter/material.dart';
import 'package:componentes/src/utils/icons_string_utils.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: _list(),
    );
  }

  Widget _list() {
    return FutureBuilder(
        future: menuProvider.cargarData(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: _listaItems(snapshot.data, context),
            );
          }
          return CircularProgressIndicator();
        });
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.pushNamed(context, opt['ruta']);
          /*final route = MaterialPageRoute(
            builder: (context)  => AlertPage()
          );
          Navigator.push(context, route);*/
        },
      );
      opciones..add(widgetTemp)..add(Divider());
    });
    return opciones;
  }
}
