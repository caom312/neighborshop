import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neighborshop/descripcionPro.dart';

class productos extends StatefulWidget {
  final String c;
  const productos(this.c, {Key? key}) : super(key: key);

  @override
  _productosState createState() => _productosState();
}

class _productosState extends State<productos> {
  List datosProducto = [];

  void initState(){
    super.initState();
    getProducto();
  }

  void getProducto() async {

    CollectionReference pro = FirebaseFirestore.instance.collection("Productos");
    QuerySnapshot produ = await pro.where("negID", isEqualTo: widget.c).get();
    if(produ.docs.length>0){
      print("Trae Datos");

      for(var doc in produ.docs){
        print(doc.data());
        setState(() {
          datosProducto.add(doc.data());
        });
      }
    }else{
      print("Ha fallado.......");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla Productos"),
      ),

      body:ListView.builder(
          itemCount: datosProducto.length,
          itemBuilder: (BuildContext context, i) {
            return ListTileWidget(
              foto: datosProducto[i]["foto"],
              nombre: datosProducto[i]["nombre"],
              precio: datosProducto[i]["precio"].toString(),
              control: datosProducto[i]["descripcion"],

            );
          }
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  final String foto;
  final String nombre;
  final String control;
  final String precio;

  ListTileWidget(
      {Key? key,
        required this.foto,
        required this.nombre,
        required this.control,
        required this.precio,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(foto),
      ),
      title: Text(
        nombre,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Text("Precio: \$"+ precio),
      isThreeLine: true,
      trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>descripcionPro(control)));
        }
    );
  }
}

