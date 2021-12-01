import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neighborshop/main.dart';
import 'package:neighborshop/registro.dart';

class modificar extends StatefulWidget {
  final String dato;
  const modificar(this.dato,{Key? key}) : super(key: key);

  @override
  _modificarState createState() => _modificarState();
}

class _modificarState extends State<modificar> {

  void initState() {
    super.initState();
    getDatos();
  }

  final nombre = TextEditingController();
  final direccion = TextEditingController();
  final telefono = TextEditingController();
  final celular = TextEditingController();
  final correo = TextEditingController();

  void limpiar(){
    nombre.text = "";
    direccion.text = "";
    telefono.text = "";
    celular.text = "";
    correo.text = "";
  }

  void getDatos() async{

    List listaCLi = [];

    CollectionReference clientes = FirebaseFirestore.instance.collection("Clientes");
    QuerySnapshot existe = await clientes.where(FieldPath.documentId, isEqualTo: widget.dato).get();
    if(existe.docs.length>0){
      for(var doc in existe.docs){
        listaCLi.add(doc.data());
      }
      nombre.text = listaCLi[0]["nombre"];
      direccion.text = listaCLi[0]["direccion"];
      telefono.text = listaCLi[0]["telefono"];
      celular.text = listaCLi[0]["celular"];
      correo.text = listaCLi[0]["correo"];
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Configure sus datos"),
      ),body: SingleChildScrollView(
      child:Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        height: size.height * 0.70,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent.withOpacity(0.3),
          borderRadius: BorderRadius.circular(29),
        ),
        child: Column(
          children: [
            campoTexto(texto: "Modificar su nombre", icono: Icons.person, vertical: 20, control: nombre,),
            campoTexto(texto: "Modificar su dirección", icono: Icons.add, vertical: 20, control: direccion,),
            campoTexto(texto: "Modificar su telefono", icono: Icons.contact_phone_sharp, vertical: 20, control: telefono,),
            campoTexto(texto: "Modificar su celular", icono: Icons.aod_outlined, vertical: 20, control: celular,),
            campoTexto(texto: "Modificar su correo", icono: Icons.email_outlined, vertical: 20, control: correo),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if(nombre.text.isEmpty || direccion.text.isEmpty || telefono.text.isEmpty || celular.text.isEmpty || correo.text.isEmpty){
                      print("Llene los espacios");
                      toast("Campos vacios");
                    }else {
                      CollectionReference clientes = FirebaseFirestore.instance.collection("Clientes");
                      QuerySnapshot exi = await clientes.where(FieldPath.documentId, isEqualTo: widget.dato).get();
                      if(exi.docs.length>0) {
                        clientes.doc(widget.dato).update({
                          "nombre": nombre.text,
                          "direccion": direccion.text,
                          "telefono": telefono.text,
                          "celular": celular.text,
                          "correo": correo.text,
                        });
                        toast("Datos modificados");
                        limpiar();
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text("Actualizar"),
                ),
                //Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    if(nombre.text.isEmpty || direccion.text.isEmpty || telefono.text.isEmpty || celular.text.isEmpty || correo.text.isEmpty){
                      print("Llene los espacios");
                      toast("Campos vacios");
                    }else {
                      CollectionReference clientes = FirebaseFirestore.instance.collection("Clientes");
                      QuerySnapshot exi = await clientes.where(FieldPath.documentId, isEqualTo: widget.dato).get();
                      if(exi.docs.length>0) {
                        clientes.doc(widget.dato).delete();
                        toast("Datos eliminados");
                        limpiar();
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text("Eliminar"),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
}