import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';

import 'package:formvalidation/src/model/producto_model.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffolKey = GlobalKey<ScaffoldState>();
  ProductosBloc productosBloc;
  ProductoModel productoModel = new ProductoModel();
  bool _guardando = false;
  PickedFile foto;

  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBloc(context);
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      productoModel = prodData;
    }
    return Scaffold(
      key: scaffolKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _crearFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _mostrarFoto(),
                  _crearNombre(),
                  _crearPrecio(),
                  _crearDisponible(),
                  _crearBoton(),
                ],
              )),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: productoModel.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value) => productoModel.titulo = value,
      validator: (value) =>
          (value.length < 3) ? 'Ingrese el nombre del producto' : null,
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: productoModel.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value) => productoModel.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumerico(value)) {
          return null;
        }
        return 'Solo números';
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: productoModel.disponible ?? true,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        productoModel.disponible = value;
      }),
    );
  }

  void _submit() async {
    // si el formulario no es valido;
    if (!formKey.currentState.validate()) return;
    // Cuando el formulario es valido
    formKey.currentState.save();
    setState(() {
      _guardando = true;
    });
    if (foto != null) {
      productoModel.fotoUrl = await productosBloc.subirFoto(foto);
    }
    if (productoModel.id == null) {
      productosBloc.agregarProducto(productoModel);
    } else {
      productosBloc.editarProducto(productoModel);
    }
    mostrarSnackbar('Registro guardado');
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffolKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto() {
    if (productoModel.fotoUrl != null) {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(productoModel.fotoUrl),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/no-image.png'),
        fit: BoxFit.cover,
        height: 300,
      );
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _crearFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    final imagePicker = ImagePicker();
    foto = await imagePicker.getImage(source: origen);

    if (foto != null) {
      productoModel.fotoUrl = null;
    }
    setState(() {});
  }
}
