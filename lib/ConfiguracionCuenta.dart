import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ConfiguracionCuenta extends StatefulWidget {
  const ConfiguracionCuenta({Key? key}) : super(key: key);

  @override
  _ConfiguracionCuentaState createState() => _ConfiguracionCuentaState();
}

class _ConfiguracionCuentaState extends State<ConfiguracionCuenta> {
  final cedula = TextEditingController();
  final nombre = TextEditingController();
  final direccion = TextEditingController();
  final telefono = TextEditingController();
  final celular = TextEditingController();
  final email = TextEditingController();
  final contrasena = TextEditingController();

  CollectionReference clientes = FirebaseFirestore.instance.collection("Clientes");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(34, 0, 51, 1),
      appBar: AppBar(
        title: Text("Configuración"),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: size.height * 0.07),
                //height: size.height * 0.7,
                //width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    campoTexto(texto: "Cedula", icono: Icons.badge_outlined, vertical: 20, control: cedula,),
                    campoTexto(texto: "Nombre", icono: Icons.person, vertical: 20, control: nombre,),
                    campoTexto(texto: "Dirección", icono: Icons.add, vertical: 20, control: direccion,),
                    campoTexto(texto: "Telefono", icono: Icons.contact_phone_sharp, vertical: 20, control: telefono,),
                    campoTexto(texto: "Celular", icono: Icons.aod_outlined, vertical: 20, control: celular,),
                    campoTexto(texto: "Email", icono: Icons.all_inbox_sharp, vertical: 20, control: email,),
                    campoTexto(texto: "Contraseña", icono: Icons.admin_panel_settings_outlined, vertical: 20, control: contrasena,),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      ElevatedButton(
                        onPressed: (){
                          if(cedula.text.isEmpty || nombre.text.isEmpty || direccion.text.isEmpty || telefono.text.isEmpty || celular.text.isEmpty || contrasena.text.isEmpty || email.text.isEmpty){
                            print("Llene los espacios");
                          }else{
                            clientes.doc(cedula.text).set({
                              "nombre": nombre.text,
                              "direccion": direccion.text,
                              "telefono": telefono.text,
                              "celular": celular.text,
                              "contraseña":contrasena.text,
                              "correo":email.text,
                            });
                          }
                        },
                        child: Text("Actualizar datos"),
                      ),

                      ElevatedButton(
                        onPressed: (){
                          if(cedula.text.isEmpty || nombre.text.isEmpty || direccion.text.isEmpty || telefono.text.isEmpty || celular.text.isEmpty || contrasena.text.isEmpty || email.text.isEmpty){
                            print("Llene los espacios");
                          }else{
                            clientes.doc(cedula.text).set({
                              "nombre": nombre.text,
                              "direccion": direccion.text,
                              "telefono": telefono.text,
                              "celular": celular.text,
                              "contraseña":contrasena.text,
                              "correo":email.text,
                            });
                          }
                        },
                        child: Text("eliminar mi cuenta"),
                      ),
                    ],)

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
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: control,
        decoration: InputDecoration(

          labelText: texto,
          labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.white
          ),
          icon: Icon(icono, color: Colors.white,),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
