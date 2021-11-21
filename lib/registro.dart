import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class registro extends StatefulWidget {
  const registro({Key? key}) : super(key: key);

  @override
  _registroState createState() => _registroState();
}

class _registroState extends State<registro> {
  final cedula = TextEditingController();
  final nombre = TextEditingController();
  final direccion = TextEditingController();
  final telefono = TextEditingController();
  final celular = TextEditingController();

  CollectionReference clientes = FirebaseFirestore.instance.collection("Clientes");

  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrate"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              height: size.height * 0.7,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(29),
              ),
                child: Column(
                  children: [
                    campoTexto(texto: "Ingrese su cedula", icono: Icons.badge_outlined, vertical: 20, control: cedula,),
                    campoTexto(texto: "Ingrese su nombre", icono: Icons.person, vertical: 20, control: nombre,),
                    campoTexto(texto: "Ingrese su dirección", icono: Icons.add, vertical: 20, control: direccion,),
                    campoTexto(texto: "Ingrese su telefono", icono: Icons.contact_phone_sharp, vertical: 20, control: telefono,),
                    campoTexto(texto: "Ingrese su celular", icono: Icons.aod_outlined, vertical: 20, control: celular,),
                    ElevatedButton(
                        onPressed: (){
                          if(cedula.text.isEmpty || nombre.text.isEmpty || direccion.text.isEmpty || telefono.text.isEmpty || celular.text.isEmpty){
                            print("Llene los espacios");
                          }else{
                            clientes.doc(cedula.text).set({
                              "nombre": nombre.text,
                              "direccion": direccion.text,
                              "telefono": telefono.text,
                              "celular": celular.text
                            });
                          }
                        },
                        child: Text("Registrarse"),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class campoTexto extends StatelessWidget {
  const campoTexto({
    Key? key,
    required this.texto,
    required this.icono,
    required this.vertical,
    required this.control,

  }) : super(key: key);

  final String texto;
  final IconData icono;
  final double vertical;
  final TextEditingController control;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: vertical),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width * 0.8,
      height: size.height * 0.07,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent.withOpacity(0.4),
        borderRadius: BorderRadius.circular(29),
      ),
    child: TextField(
      controller: control,
      decoration: InputDecoration(
        hintText: texto,
        hintStyle: TextStyle(
            color: Colors.deepPurpleAccent
        ),
        icon: Icon(icono, color: Colors.deepPurpleAccent,),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}



