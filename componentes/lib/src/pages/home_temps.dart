import 'package:flutter/material.dart';

class HomePagesTemp extends StatelessWidget {
  final options = ['Uno', 'dos', 'tres', 'Cuatro', 'Cinco'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Componentes'),
          ),
          body: ListView(
//            children: _crearItems(),
            children: _crearItemsCorta(),
          )),
    );
  }

  List<Widget> _crearItems() {
    List<Widget> lista = new List<Widget>();
    for (var opt in options) {
      final tempWidget = ListTile(
        title: Text(opt),
      );
      lista..add(tempWidget)..add(Divider());
    }
    return lista;
  }

  List<Widget> _crearItemsCorta() {
    return options.map((item) {
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(item),
            subtitle: Text('cualquier cosa'),
            leading: Icon(Icons.account_balance_wallet),
            trailing: Icon(Icons.arrow_forward),
            onTap: (){},
          ),
        ],
      );
    }).toList();
  }
}
