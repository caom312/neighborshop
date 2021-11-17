import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class consultanegocios extends StatelessWidget {
  const consultanegocios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla Negocios"),
      ),

      body: 
      SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:
      Column(
        children: [
    //      ListView(
    //        children: [
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 0,
                ),
                //height: size.height * 0.2 - 27,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 54,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Colors.deepPurple.withOpacity(1),
                        ),
                      ]),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Busca un negocio..",
                      hintStyle: TextStyle(
                        color: Colors.deepPurple,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      icon: Image.asset(
                        "assets/iconos/001.png",
                        color: Colors.deepPurple,
                        scale: 50,
                      ),
                    ),
                  ),
                ),
              ),
              TileList(),
            ],
          ),
      //  ],
      ),
    );
  }
}

// esto construye la lista con variables
class ListTileWidget extends StatelessWidget {
  final String urlstr;
  final String nombre;
  final String direccion;
  final String contacto;

  ListTileWidget(
      {Key? key,
      required this.urlstr,
      required this.nombre,
      required this.direccion,
      required this.contacto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(urlstr),
        ),
        title: Text(
          nombre,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(direccion + '\n' + contacto),
        isThreeLine: true,
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          print('vamos a la pantalla detalles' + nombre);
        });
  }
}

// aqui se cargan los datos de la lista per se
class TileList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: ListTile.divideTiles(context: context, tiles: [
        ListTileWidget(
            //key: key,
            urlstr: 'http://tinyimg.io/i/vCc6wmD.jpg',
            nombre: 'nombre1',
            direccion: 'direccion1',
            contacto: 'contacto1'),
        ListTileWidget(
            //key: key,
            urlstr: 'http://tinyimg.io/i/vCc6wmD.jpg',
            nombre: 'nombre2',
            direccion: 'direccion2',
            contacto: 'contacto2'),
        ListTileWidget(
            urlstr: 'http://tinyimg.io/i/vCc6wmD.jpg',
            nombre: 'nombre3',
            direccion: 'direccion3',
            contacto: 'contacto3'),
        ListTileWidget(
            urlstr: 'http://tinyimg.io/i/vCc6wmD.jpg',
            nombre: 'nombre4',
            direccion: 'direccion4',
            contacto: 'contacto4'),
        ListTileWidget(
            urlstr: 'http://tinyimg.io/i/vCc6wmD.jpg',
            nombre: 'nombre5',
            direccion: 'direccion5',
            contacto: 'contacto5'),
        ListTileWidget(
            urlstr: 'http://tinyimg.io/i/vCc6wmD.jpg',
            nombre: 'nombre6',
            direccion: 'direccion6',
            contacto: 'contacto6'),
        ListTileWidget(
            urlstr: 'http://tinyimg.io/i/vCc6wmD.jpg',
            nombre: 'nombre7',
            direccion: 'direccion7',
            contacto: 'contacto7'),
        ListTileWidget(
            urlstr: 'http://tinyimg.io/i/vCc6wmD.jpg',
            nombre: 'nombre8',
            direccion: 'direccion8',
            contacto: 'contacto8'),
        ListTileWidget(
            urlstr: 'http://tinyimg.io/i/vCc6wmD.jpg',
            nombre: 'nombre9',
            direccion: 'direccion9',
            contacto: 'contacto9'),
        ListTileWidget(
            urlstr: 'http://tinyimg.io/i/vCc6wmD.jpg',
            nombre: 'nombre10',
            direccion: 'direccion10',
            contacto: 'contacto10'),
      ]).toList(),
    );
  }
}

//este es un tilelist con solo una fila, a modo de ejemplo.
class tileone extends StatelessWidget {
  const tileone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('http://tinyimg.io/i/vCc6wmD.jpg'),
          ),
          title: Text(
            'negocio1',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('direccionNegocio1' + '\ncontacto'),
          isThreeLine: true,
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print('vamos a la pantalla detalles negocio');
          }),
    );
  }
}
