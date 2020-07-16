import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:formvalidation/src/preferecias_usuario/preferencias_usuario.dart';

import 'package:formvalidation/src/model/producto_model.dart';

class ProductoProvider {
  final String _url = 'https://flutter-varios-76cb4.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json?auth=${_prefs.token}';
    final resp = await http.post(url, body: productoModelToJson(producto));
    final decodedDate = json.decode(resp.body);
    print(decodedDate);
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json?auth=${_prefs.token}';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedDate = json.decode(resp.body);
    final List<ProductoModel> productos = new List();
    if (decodedDate == null) return [];
    if(decodedDate['error'] != null) return [];
    decodedDate.forEach((key, value) {
      final prodTemp = ProductoModel.fromJson(value);
      prodTemp.id = key;
      productos.add(prodTemp);
    });
    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);
    print(resp.body);
    return 1;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json?auth=${_prefs.token}';
    final resp = await http.put(url, body: productoModelToJson(producto));
    final decodedDate = json.decode(resp.body);
    print(decodedDate);
    return true;
  }

  Future<String> subirImagen(PickedFile imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/djhxmjnb4/image/upload?upload_preset=um7mj5dg');
    final mimeType = mime(imagen.path).split('/'); //imagen/jpeg
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }
    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}
