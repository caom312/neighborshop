import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neighborshop/menulateral/menuLateral.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List datos_personas=[];
  void initState(){
    super.initState();
    getPersonas();
  }

  //llamada o conexion a la base de datos
  void getPersonas() async {
      //utilizamos las dependencias, Conectar la coleccion
    CollectionReference datos= FirebaseFirestore.instance.collection("Personas");
    //consultamos y traemos todas las personas, igual select * from tabla
    QuerySnapshot personas= await datos.get();

    if(personas.docs.length>0){
      print("Trae Datos");
      for(var doc in personas.docs){
        print(doc.data());
        datos_personas.add(doc.data());
      }
    }else{
      print("Ha fallado.......");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla Negocios"),
      ),
      drawer: drawermenulateral(context),
      body: Center(
        child: ListView.builder(
          //longitud items a generar
          itemCount: datos_personas.length,
          itemBuilder: (BuildContext context,i){
            return ListTile(
              title: Text("Persona "+i.toString()+" - "+datos_personas[i]['nombre'].toString()),
            ) ;
          },
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}










class consultanegocios extends StatelessWidget {
  List datos_personas=[];

  //const consultanegocios({Key? key}) : super(key: key);
  
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
      Center(
        
        child: ListView.builder(
          //longitud items a generar
          itemCount: datos_personas.length,
          itemBuilder: (BuildContext context,i){
            return ListTile(
              title: Text("Persona "+i.toString()+" - "+datos_personas[i]['nombre'].toString()
                  +datos_personas[i]['categoria'].toString()),


            ) ;
          },
        ),

     ),
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
              Center(
        child: ListView.builder(
          //longitud items a generar
          itemCount: datos_personas.length,
          itemBuilder: (BuildContext context,i){
            return ListTile(
              title: Text("Persona "+i.toString()+" - "+datos_personas[i]['nombre'].toString()
                  +datos_personas[i]['categoria'].toString()),
            ) ;
          },
        ),
     ),

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
