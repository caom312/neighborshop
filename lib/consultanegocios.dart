import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class  consultanegocios extends StatelessWidget {
  const consultanegocios ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla Negocios"),
      ),
      body: PageView(
        children:[
       Container(
      child: Text("esta es la pantalla Consulta por negocio"),
    ),

        ],
      ),

    );




  }


}
