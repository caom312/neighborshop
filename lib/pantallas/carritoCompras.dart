import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neighborshop/menulateral/menuLateral.dart';
import 'package:neighborshop/pantallas/listanegociosPedido.dart';
import 'package:neighborshop/pantallas/registrarPedido.dart';

class carritoCompras extends StatefulWidget {

  final List<datosPedido> pedido;
  final String id;
  final String cedula;

  const carritoCompras({required this.pedido, required this.cedula, required this.id});

  @override
  _carritoComprasState createState() => _carritoComprasState();
}

class _carritoComprasState extends State<carritoCompras> {
  int _cantidad = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito de Compras"),
      ),
      drawer: drawermenulateral(context),
      body: Center(
        child: ListView.builder(
            itemCount: widget.pedido.length,
            itemBuilder: (BuildContext context, i){
              return Card(
                child:ListTile(

                title: Text(widget.pedido[i].nombre+"\n\u0024"+widget.pedido[i].precio.toString()+" x "+
                    widget.pedido[i].cant.toString()+" = \u0024"+widget.pedido[i].total.toString()),
                trailing: Icon(Icons.delete, size: 30, color: Colors.deepPurple,),

                onTap: (){
                  widget.pedido.removeAt(i);
                  setState(() { });
                },
                )


              );

            }
        ),
      ),
      bottomNavigationBar: carritoBar(listaPedido: widget.pedido, cliente: widget.cedula, negocio: widget.id),
    );
  }
}

class carritoBar extends StatefulWidget {

  final List<datosPedido> listaPedido;
  final String negocio;
  final String cliente;
  const carritoBar({required this.listaPedido, required this.negocio, required this.cliente}) ;


  @override
  _carritoBarState createState() => _carritoBarState();
}

class _carritoBarState extends State<carritoBar> {

  void registrarDetalle(codP){

    CollectionReference detalle = FirebaseFirestore.instance.collection("DetallePedido");
    for(var dato=0; dato< widget.listaPedido.length; dato++){
      detalle.add({
        "pedido": codP,
        "producto": widget.listaPedido[dato].codigo,
        "cantidad": widget.listaPedido[dato].cant,
        "total": widget.listaPedido[dato].total
      });
    }
  }
  void registrarP(){

    DateTime hoy = new DateTime.now();
    DateTime fecha = new DateTime(hoy.year, hoy.month, hoy.day);
    int totalP=0;
    //String codPedido;
    for(int i=0; i< widget.listaPedido.length; i++){
      totalP+=widget.listaPedido[i].total;
    }
    CollectionReference pedidos = FirebaseFirestore.instance.collection("Pedidos");
    pedidos.add({
      "negocio": widget.negocio,
      "cedula": widget.cliente,
      "fecha": fecha,
      "Total": totalP
    }).then((value) => registrarDetalle(value.id));

  }

  @override
  Widget build(BuildContext context) {


    return BottomNavigationBar(
      backgroundColor: Colors.deepPurple,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart_sharp, size: 30),
            label: "Agregar\nProducto"
        ),
        /*BottomNavigationBarItem(
            icon: Icon(Icons.app_registration, size: 30),
            label: "TOTAL"
        ),*/
        BottomNavigationBarItem(
            icon: Icon(Icons.paid, size: 30),
            label: "Confirmar\nPedido"
        )
      ],
      onTap: (indice){
        if(indice==0){
          Navigator.pop(context);
        }else if(indice==1){
          int totalPedido=0;
          for(int i=0; i< widget.listaPedido.length; i++){
            totalPedido+=widget.listaPedido[i].total;
          }
          print("Total es: "+totalPedido.toString());
          showDialog(
              context: context,
              builder: (context)=>AlertDialog(
                title: Text("Confirmar Compra:", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
                contentPadding: EdgeInsets.all(23.0),
                content: Text('Total a Pagar : \u0024'+totalPedido.toString(), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
                //content: Text("Confirma el registro de la Compra.", style: TextStyle(fontSize: 16.0, color: Colors.green),),
                actions: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancelar")

                  ),
                  ElevatedButton(
                      onPressed: (){
                        registrarP();
                        Fluttertoast.showToast(msg: "Pedido Registrado exitosamente.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                            toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>listanegociosPedido(cedula: widget.cliente)));
                      },
                      child: Text("Confirmar")


                  )
                ],
              ));


          /*showDialog(

              context: context,
              builder: (context)=>AlertDialog(
                title: Text("Total de la Compra:", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
                contentPadding: EdgeInsets.all(20.0),
                content: Text('\u0024'+totalPedido.toString(), style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
              ));*/
        }/*else{
          int totalPedido=0;
          for(int i=0; i< widget.listaPedido.length; i++){
            totalPedido+=widget.listaPedido[i].total;
          }
          showDialog(
              context: context,
              builder: (context)=>AlertDialog(
                title: Text("Confirmar Compra:", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
                contentPadding: EdgeInsets.all(23.0),
                content: Text('Total a Pagar : \u0024'+totalPedido.toString(), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
                //content: Text("Confirma el registro de la Compra.", style: TextStyle(fontSize: 16.0, color: Colors.green),),
                actions: [
                  ElevatedButton(
                      onPressed: (){
                        registrarP();
                        Fluttertoast.showToast(msg: "Pedido Registrado exitosamente.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                            toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>listanegociosPedido(cedula: widget.cliente)));
                      },
                      child: Text("Confirmar")
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancelar")
                  )
                ],
              ));

        }*/
      },
    );
  }
}

