import 'package:flutter/material.dart';
import 'package:ruthapp/administracion/productos/producto.dart';
import 'package:ruthapp/administracion/productos/servicio-productos.dart';

class ModificarProducto extends StatefulWidget {
  final Producto producto;

  ModificarProducto(@required this.producto);

  @override
  State<StatefulWidget> createState() {
    return _ModificarProductoState();
  }
}

class _ModificarProductoState extends State<ModificarProducto> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  ServicioProducto servicioProducto = new ServicioProducto();

  Producto _productoModificar;

  @override
  Widget build(BuildContext context) {
    this._productoModificar = widget.producto;
    return Scaffold(
        appBar: AppBar(
          title: Text('Modificar - ${_productoModificar.nombre}'),
        ),
        body: Stack(
          children: <Widget>[
            _crearFormulario(context),
            _crearBotonGuardar(context)
          ],
        ));
  }

  Form _crearFormulario(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          _crearTextFieldNombre(),
          _crearTextFieldPrecio(),
          _crearTextFieldCantidad(),
          _crearTextFieldImagen()
        ],
      ),
    );
  }

  TextFormField _crearTextFieldNombre() {
    return TextFormField(
      initialValue: this._productoModificar.nombre,
      onSaved: (String nombre) {
        this._productoModificar.nombre = nombre;
      },
      enabled: false,
      decoration: InputDecoration(
        icon: Icon(Icons.local_grocery_store),
        hintText: 'Ingrese el nombre del producto',
        labelText: 'Nombre',
      ),
    );
  }

  TextFormField _crearTextFieldPrecio() {
    return TextFormField(
      initialValue: this._productoModificar.precio.toString(),
      onSaved: (String precio) {
        this._productoModificar.precio = int.parse(precio);
      },
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        icon: Icon(Icons.attach_money),
        hintText: 'Ingrese el precio del producto',
        labelText: 'Precio',
      ),
    );
  }

  TextFormField _crearTextFieldCantidad() {
    return TextFormField(
      initialValue: this._productoModificar.cantidad.toString(),
      onSaved: (String cantidad) {
        this._productoModificar.cantidad = int.parse(cantidad);
      },
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        icon: Icon(Icons.format_list_numbered),
        hintText: 'Ingrese la cantidad del producto',
        labelText: 'Cantidad',
      ),
    );
  }

  TextFormField _crearTextFieldImagen() {
    return TextFormField(
      initialValue: this._productoModificar.imagen,
      onSaved: (String imagen) {
        this._productoModificar.imagen = imagen;
      },
      decoration: InputDecoration(
        icon: Icon(Icons.image),
        hintText: 'Ingrese una imagen del producto',
        labelText: 'Imagen',
      ),
    );
  }

  Container _crearBotonGuardar(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.bottomRight,
        child: Builder(builder: (BuildContext context) {
          return FloatingActionButton(
            tooltip: 'Modificar Producto',
            onPressed: () {
              _mostrarConfirmacion(context);
            },
            child: Icon(Icons.edit),
          );
        }));
  }

  void _modificarProducto(BuildContext context) {
    print('Entro a modificar Producto !');
    _formKey.currentState.save();
    this.servicioProducto.modificarProducto(this._productoModificar);
    Navigator.pop(context, true); 
  }

  void _mostrarConfirmacion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmacion'),
          content: Text('¿Esta seguro de modificar el producto?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                _modificarProducto(context);
              },
            )            
          ],
        );
      },
    );
  }
}
