import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:formvalidation/src/model/producto_model.dart';
import 'package:formvalidation/src/providers/producto_provider.dart';

class ProductosBloc {
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();
  final _productoProvaider = new ProductoProvider();

  Stream<List<ProductoModel>> get prodcutosStream =>
      _productosController.stream;

  Stream<bool> get cargando => _cargandoController.stream;

  void cargarProducto() async {
    final producto = await _productoProvaider.cargarProductos();
    _productosController.sink.add(producto);
  }

  void agregarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productoProvaider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  Future<String> subirFoto(PickedFile foto) async {
    print(foto);
    _cargandoController.sink.add(true);
    final fotoUrl = await _productoProvaider.subirImagen(foto);
    _cargandoController.sink.add(false);
    print(fotoUrl);
    return fotoUrl;
  }

  void editarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productoProvaider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  void borrarProducto(String id) async {
    await _productoProvaider.borrarProducto(id);
  }

  dispose() {
    _productosController?.close();
    _cargandoController?.close();
  }
}
