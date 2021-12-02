import 'package:flutter/material.dart';
import 'package:neighborshop/configuracion.dart';
import 'package:neighborshop/pantallas/listarnegocios.dart';
import 'package:neighborshop/pantallas/moduloPedido.dart';
import '../busquedapro.dart';
import '../main.dart';
import '../registro.dart';


Drawer drawermenulateral(BuildContext context) {
  return Drawer(

      child: ListView(

        children:<Widget> [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),

              accountName: Text('NeighborShop',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 25),),
              accountEmail: Text('')
          ),
          ListTile(
          title: Text('Home',style: TextStyle(fontSize: 15),),
          leading: Icon(Icons.home),

          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));

          },
          ),
          ListTile(
            title: Text('Registrarse',style: TextStyle(fontSize: 15),),
            leading: Icon(Icons.account_box_outlined),

            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> registro()));
            },
          ),
          ListTile(
            title: Text('Consultar Negocios',style: TextStyle(fontSize: 15),),
            leading: Icon(Icons.search_outlined),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> listarnegocios()));
            },
          ),
          ListTile(
            title: Text('Consultar Productos',style: TextStyle(fontSize: 15),),
            leading: Icon(Icons.search_outlined),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> busquedapro()));
            },
          ),
          ListTile(
            title: Text('Registrar Pedidos',style: TextStyle(fontSize: 15),),
            leading: Icon(Icons.shopping_cart),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> moduloPedido()));

            },
          ),
          ListTile(
            title: Text('Configuracion',style: TextStyle(fontSize: 15),),
            leading: Icon(Icons.settings),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> configuarcion()));

            },
          ),
          ListTile(
            title: Text('Salir',style: TextStyle(fontSize: 15),),
            leading: Icon(Icons.logout_outlined),
            onTap: (){
              //exit(0);

            },
          ),


        ],


      )



  );
}