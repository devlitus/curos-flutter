import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valorSlider = 400.0;
  bool _blockCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            _createSlider(),
            _checkBox(),
            _createSwitch(),
            Expanded(child: _crearImagen()),
          ],
        ),
      ),
    );
  }

  Widget _createSlider() {
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de la imagen',
      value: _valorSlider,
      min: 0.0,
      max: 400.0,
      onChanged: (_blockCheck)
          ? null
          : (value) => setState(() {
                _valorSlider = value;
              }),
    );
  }

  Widget _checkBox() {
    /*return Checkbox(
      value: _blockCheck,
      onChanged: (value) {
        setState(() {
          _blockCheck = value;
        });
      },
    );*/
    return CheckboxListTile(
      title: Text('Bloquear Silder'),
      value: _blockCheck,
      onChanged: (value) {
        setState(() {
          _blockCheck = value;
        });
      },
    );
  }

  Widget _crearImagen() {
    return Image(
      image: NetworkImage(
          'https://www.merchandisingplaza.es/324344/2/Munecos-de-accion-Batman-Muneco-de-accion-Batman-324344-l.jpg'),
      width: _valorSlider,
      fit: BoxFit.contain,
    );
  }

  Widget _createSwitch() {
    return SwitchListTile(
      title: Text('Bloquear Silder'),
      value: _blockCheck,
      onChanged: (value) {
        setState(() {
          _blockCheck = value;
        });
      },
    );
  }
}
