import 'package:flutter/material.dart';
import 'package:neighborshop/pantallas/listarnegocios.dart';
import '../busquedapro.dart';
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
          /*
          Container(
            color: Colors.deepPurple,
            width: 100,
            height: 100,
            child: Text('NeighborShor',style: TextStyle(color:Colors.white)),
            //child: Image.network("https://firebasestorage.googleapis.com/v0/b/grupo15caom.appspot.com/o/logo%2FlogoNeighborshop.png?alt=media&token=8a18decd-321f-4fcd-bd1e-187824cf0883"),
          ),
          */

          ListTile(
            title: Text('Iniciar Sesion',style: TextStyle(fontSize: 15),),
            leading: Icon(Icons.login_outlined),
            onTap: (){

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
            title: Text('Salir',style: TextStyle(fontSize: 15),),
            leading: Icon(Icons.logout_outlined),
            onTap: (){

            },
          ),


        ],


      )



  );
}