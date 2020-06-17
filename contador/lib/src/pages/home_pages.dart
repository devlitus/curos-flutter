import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final estiloTexto = new TextStyle(fontSize: 25);
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Título')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Número de click!!', style: estiloTexto),
              Text(
                '$contador',
                style: estiloTexto,
              ),
            ],
          ),
        ),
        floatingActionButton: _CrearBotones());
  }

  Widget _CrearBotones() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 30,
        ),
        _botonFlotanteZero(),
        Expanded(child: SizedBox()),
        _botonFlotanteDecrementar(),
        SizedBox(
          width: 5.0,
        ),
        _botonFlotanteIncrementar(),
      ],
    );
  }

  Widget _botonFlotanteIncrementar() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() => contador++);
        });
  }

  Widget _botonFlotanteDecrementar() {
    return FloatingActionButton(
        child: Icon(Icons.remove),
        onPressed: () {
          setState(() => contador--);
        });
  }

  Widget _botonFlotanteZero() {
    return FloatingActionButton(
        child: Icon(Icons.exposure_zero),
        onPressed: () {
          setState(() => contador = 0);
        });
  }
}
