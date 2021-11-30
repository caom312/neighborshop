import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neighborshop/menulateral/menuLateral.dart';
import 'package:neighborshop/pantallas/registrarPedido.dart';





class listanegociosPedido extends StatefulWidget {
  final String cedula;
  const listanegociosPedido({required this.cedula});

  @override
  _listanegociosPedidoState createState() => _listanegociosPedidoState();
}

class _listanegociosPedidoState extends State<listanegociosPedido> {

  List negocios=[];
  List codigos=[];

  void initState(){
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    CollectionReference negocio = FirebaseFirestore.instance.collection("Negocios");
    String id="";
    QuerySnapshot datos = await negocio.get();
    if(datos.docs.length>0){
      for(var doc in datos.docs){
        id=doc.id.toString();
        codigos.add(id);
        negocios.add(doc.data());

      }
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Negocios"),
      ),
      drawer: drawermenulateral(context),
      body: ListView.builder(
          itemCount: negocios.length,
          itemBuilder: (BuildContext context,j){
            return ListTile(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>registrarPedido(id: codigos[j], cedula: widget.cedula)));
                },
              title: Text(negocios[j]['nombre'].toString()),
              subtitle:Text(negocios[j]['categoria'].toString()),
              /*leading:CircleAvatar(
                child:Text(datos_negocios[j]['nombre'].substring(0,1)),
              ),*/
              trailing: Icon(Icons.arrow_forward_ios),
              leading:SizedBox(
                width: 70,
                height: 70,
                child: Image.network(negocios[j]['logo']),
              ),
                //title: miCardImage(url: negocios[i]['foto'],texto: negocios[i]['nombre']+" "+negocios[i]['categoria'])
            );
          }),
    );
  }
}
