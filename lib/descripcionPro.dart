import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neighborshop/pantallas/listarnegocios.dart';

import 'menulateral/menuLateral.dart';

class descripcionPro extends StatefulWidget {
  final String con;
  const descripcionPro( this.con, {Key? key}) : super(key: key);

  @override
  _descripcionProState createState() => _descripcionProState();
}

class _descripcionProState extends State<descripcionPro> {
  List listaProducto = [];

  void initState() {
    super.initState();
    getDescripcion();
  }

  void getDescripcion() async {
    CollectionReference pro = FirebaseFirestore.instance.collection(
        "Productos");
    QuerySnapshot produ = await pro.where("descripcion", isEqualTo: widget.con)
        .get();
    if (produ.docs.length > 0) {
      print("Trae Datos");

      for (var doc in produ.docs) {
        print(doc.data());
        setState(() {
          listaProducto.add(doc.data());
        });
      }
    } else {
      print("Ha fallado.......");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(listaProducto[0]["nombre"]),
      ),
      drawer: drawermenulateral(context),
      body: ListView.builder(
          itemCount: listaProducto.length,
          itemBuilder: (BuildContext context, i) {
            return Column(
              children: [
                miCardImage(url: listaProducto[i]["foto"], texto: widget.con),
              ],
            );
          }
      ),
    );
  }
}
