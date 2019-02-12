import 'package:flutter/material.dart';
import 'package:ruthapp/administracion/tienda/servicio-tienda.dart';
import 'package:ruthapp/administracion/tienda/tienda.dart';

class InfoTienda extends StatefulWidget {

  final Tienda tienda;

  InfoTienda(@required this.tienda);

  @override
  State<StatefulWidget> createState() {
    return _InfoTiendaState();
  }
}

class _InfoTiendaState extends State<InfoTienda> {

  ServicioTienda servicioTienda = new ServicioTienda();

  Tienda _tiendaSeleccionada;

  @override
  Widget build(BuildContext context) {
    this._tiendaSeleccionada = widget.tienda;
    return Scaffold(
        appBar: AppBar(
          title: Text('Información Tienda'),
        ),
        body: _crearPanelInformacionTienda()
    );
  }

  FutureBuilder _crearPanelInformacionTienda() {
    return FutureBuilder<bool>(
      future: servicioTienda.esClienteSuscritoATienda(this._tiendaSeleccionada),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {          
          case ConnectionState.done:
            if(snapshot.data){
              return _crearPanelYaSuscrito();
            }else{
              return _crearPanelSuscripcion();
            }
            break;
          default:
            return Text('Cargando ...');
        }
      },
    );
  }

  Container _crearPanelSuscripcion(){
    return Container(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          _crearImagenTienda(),
          _crearInfo(),
          _crearBotonSuscribir()
        ],
        )
      );
  }  

  Hero _crearLogo() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 30.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 70.0,
          child: Image.asset(this._tiendaSeleccionada.imagen),
        ),
      ),
    );
  }

  Container _crearInfo(){
    return Container(
      child: Column(
        children: <Widget>[
          _crearTitulo(),
          _crearDescripcion()          
        ],
      )
    );
  }

  Container _crearTitulo(){
    return Container(
      padding: EdgeInsets.all(15),
      child: Text(
        this._tiendaSeleccionada.nombre,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Container _crearDescripcion(){
    return Container(
      child: Text(
        this._tiendaSeleccionada.descripcion,
        style: TextStyle(
          fontSize: 15.0
        ),
      ),
    );
  }

  Container _crearBotonSuscribir() {
    return Container(
        padding: EdgeInsets.only(top: 35),
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.blue,
          child: Text('Suscribirse !',
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
          onPressed:(){
            _mostrarConfirmacion();
          } 
        ));
  }

  Container _crearPanelYaSuscrito(){
    return Container(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          _crearLogo(),
          Center(
            child: Text(
              'Ya estas suscrito !',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
            )
          )
        ],
      )
    );
  }

  Hero _crearImagenTienda() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 30.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 70.0,
          child: Image.asset(this._tiendaSeleccionada.imagen),
        ),
      ),
    );
  }

  void _mostrarConfirmacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmacion'),
          content: Text('¿Esta seguro de suscribirse a esta tienda?'),
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
                _mostrarInfoSuscripcion();
              },
            )            
          ],
        );
      },
    );
  }

  void _mostrarInfoSuscripcion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Suscripcion existosa'),
          content: Text('Suscripcion pendiente de aprobacion por el tendero.'),          
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                _suscribirUsuario(context);
              },
            )            
          ],
        );
      },
    );
  }

  void _suscribirUsuario(BuildContext context){
    print('Suscribiendo usuario');
    servicioTienda.suscribirCliente(this._tiendaSeleccionada);
    Navigator.of(context).pop();
  }

}