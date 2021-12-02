import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neighborshop/menulateral/menuLateral.dart';
import 'package:neighborshop/modificar.dart';
import 'package:neighborshop/registro.dart';

class configuarcion extends StatefulWidget {
  const configuarcion({Key? key}) : super(key: key);

  @override
  _configuarcionState createState() => _configuarcionState();
}

class _configuarcionState extends State<configuarcion> {
  final cedula = TextEditingController();
  final correo = TextEditingController();

  void limpiar (){
    cedula.text = "";
    correo.text = "";
  }
  CollectionReference cliente =  FirebaseFirestore.instance.collection("Clientes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Configuracion"),
        ),
        drawer: drawermenulateral(context),
        body: ListView(children: [
          Container(
            child: Text(
              "Verifique sus datos",
              style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold, fontSize: 25),
            ),

          ),

          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: cedula,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Ingrese su Cédula',
                    prefixIcon: Icon(Icons.account_box_outlined, color: Colors.deepPurple),
                    // fillColor: Colors.deepPurple,
                    //filled: true,
                    //icon: Icon(Icons.badge_outlined,size: 25, color: Colors.deepPurple),
                    hintText: "Ingrese su Cédula",
                    hintStyle: TextStyle(color: Colors.white)),
              )),

          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: correo,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Ingrese su Correo',
                    prefixIcon: Icon(Icons.account_box_outlined, color: Colors.deepPurple),

                    //fillColor: Colors.deepPurple,
                    //filled: true,
                    //icon: Icon(Icons.email_outlined, size: 25, color: Colors.deepPurple),
                    hintText: "Ingrese su Correo",
                    hintStyle: TextStyle(color: Colors.white)),
              )),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                if(cedula.text.isEmpty || correo.text.isEmpty){
                  toast("Campos vacios");
                }else{
                QuerySnapshot ingreso = await cliente.where(FieldPath.documentId, isEqualTo: cedula.text).where("correo", isEqualTo: correo.text).get();
                List listaNegocio = [];
                if (ingreso.docs.length > 0) {
                  for (var neg in ingreso.docs) {
                    listaNegocio.add(neg.data());
                  }
                  Navigator.push(context, MaterialPageRoute (builder: (context) =>modificar(cedula.text)));
                  toast("Cargando datos");
                  //limpiar();
                } else {
                  toast("Datos incorrectos");
                  limpiar();
                }
                }
              },
              child: Text("Ingresar", style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          )
        ]));
  }
}
