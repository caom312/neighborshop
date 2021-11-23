import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neighborshop/productos.dart';

class negocios extends StatefulWidget {
  final String datos;
  const negocios(this.datos, {Key? key}) : super(key: key);

  @override
  _negociosState createState() => _negociosState();
}

class _negociosState extends State<negocios> {
  List negocioLista =[];

  void initState() {
    super.initState();
    getDato();
  }
  void getDato() async{
    CollectionReference dato = FirebaseFirestore.instance.collection("Negocios");
    QuerySnapshot negocio = await dato.where("categoria", isEqualTo: widget.datos).get();
    if (negocio.docs.length !=0){
      for(var neg in negocio.docs){
        setState(() {
          negocioLista.add(neg);
        });
        print(neg.data());
      }
    }else{
      print("no hay dato");

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla Negocios"),
      ),

      body:ListView.builder(
          itemCount: negocioLista.length,
          itemBuilder: (BuildContext context, i) {
            return ListTileWidget(
              foto: negocioLista[i]["foto"],
              nombre: negocioLista[i]["nombre"],
              direccion: negocioLista[i]["categoria"],
              controlador: negocioLista[i]["negID"],
            );
          }
      ),
    );
  }
}

// esto construye la lista con variables
class ListTileWidget extends StatelessWidget {
  final String foto;
  final String nombre;
  final String direccion;
  final String controlador;

  ListTileWidget(
      {Key? key,
        required this.foto,
        required this.nombre,
        required this.direccion,
        required this.controlador,
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
        subtitle: Text(direccion),
        isThreeLine: true,
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>productos(controlador)));
        });
  }
}
