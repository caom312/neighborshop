import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neighborshop/menulateral/menuLateral.dart';

import 'carritoCompras.dart';

class registrarPedido extends StatefulWidget {
  final String id,cedula;
  const registrarPedido({required this.id, required this.cedula});

  @override
  _registrarPedidoState createState() => _registrarPedidoState();
}

class _registrarPedidoState extends State<registrarPedido> {
  List listaProductos=[];
  List codigosProductos=[];
  List<datosPedido> pedido=[];

  void initState(){
    super.initState();

    getProductos();
  }

  void getProductos() async {

    CollectionReference productos = FirebaseFirestore.instance.collection("Productos");
    String cod="";
    QuerySnapshot producto = await productos.where("negID", isEqualTo: widget.id).get();
    if(producto.docs.length>0){
      for(var doc in producto.docs){
        cod=doc.id.toString();
        codigosProductos.add(cod);
        listaProductos.add(doc.data());
      }
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registrar Pedido"),
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>carritoCompras(pedido: pedido, cedula: widget.cedula, id: widget.id)));
                }, icon: Icon(Icons.add_shopping_cart, size: 30, color: Colors.amber))
          ],
        ),
        drawer: drawermenulateral(context),
        body: ListView.builder(
            itemCount: listaProductos.length,
            itemBuilder: (BuildContext context,i){
              var can = TextEditingController();
              return Card(

                  child: ListTile(

                  leading:SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(listaProductos[i]['foto']),
                ),

                  //Icon(Icons.add_box, size: 30,color: Colors.blue),
                  title: Container(
                    padding: EdgeInsets.all(20.0),
                    //color: Colors.yellow,
                    child: Text(listaProductos[i]['nombre']+"\n\u0024"+listaProductos[i]['precio'].toString()),

                  ),
                  trailing:  Icon(Icons.add_circle,size: 35,color: Colors.deepPurple,),

                  subtitle: TextField(
                    controller: can,
                  decoration: InputDecoration(
                      hintText: "Cantidad"
                  ),
                ),
                onTap: (){
                  if(can.text.isEmpty || int.parse(can.text) <=0){
                    can.text="0";
                    //color:Colors.deepPurple.withOpacity(0.4);
                    Fluttertoast.showToast(msg: "Por favor ingrese la cantidad a comprar",
                        fontSize: 20,
                        backgroundColor: Colors.red,
                        textColor: Colors.lightGreen,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER);

                  }else{
                    int total=int.parse(can.text)*(int.parse(listaProductos[i]['precio'].toString()));
                    datosPedido p = datosPedido(codigosProductos[i], listaProductos[i]['nombre'], listaProductos[i]['descripcion'],
                        listaProductos[i]['precio'].toString(), int.parse(can.text), total);
                    pedido.add(p);

                    Fluttertoast.showToast(msg: "Producto "+listaProductos[i]['nombre']+" se adiciono al carrito de compra",
                        fontSize: 20,
                        backgroundColor: Colors.red,
                        textColor: Colors.lightGreen,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER);
                  }

                },
              )
              );
            })

    );
  }
}

class datosPedido{

  String codigo="";
  String nombre="";
  String descripcion="";
  String precio="";
  int cant=0;
  int total=0;

  datosPedido(this.codigo, this.nombre, this.descripcion, this.precio, this.cant, this.total);
}
