import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class  pantalla2 extends StatelessWidget {
  const pantalla2 ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla #2"),
      ),
      body: PageView(
        children:[
       Container(
      child: Text("esta es la pantalla 2"),
    ),

        ],
      ),

    );




  }


}