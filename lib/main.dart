import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:neighborshop/registro.dart';

import 'menulateral/menuLateral.dart';
import 'package:neighborshop/negocios.dart';
//import 'registro.dart';


void main() {
  //inicialice las dos primeras dependencias
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value){
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NeighborShop',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Home NeighborShop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*List datos_negocios=[];
  void initState(){
    super.initState();
    getPersonas();
  }

  //llamada o conexion a la base de datos
  void getPersonas() async {
    //utilizamos las dependencias, Conectar la coleccion
    CollectionReference datos= FirebaseFirestore.instance.collection("Negocios");
    //consultamos y traemos todas las personas, igual select * from tabla
    QuerySnapshot personas= await datos.get();

    if(personas.docs.length>0){
      print("Trae Datos");

      for(var doc in personas.docs){
        print(doc.data());
        setState(() {
          datos_negocios.add(doc.data());


        });

      }
    }else{
      print("Ha fallado.......");
    }
  }
*/
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer:  drawermenulateral(context),
      appBar: buildAppBar(),
      body: body(),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text("NeighborShop"),
      /*actions: [
        IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>registro()));
            },
            icon: Icon(Icons.add),
        )
      ],*/
    );
  }

}

class body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children:[
          Container(
            height: size.height * 0.2,
            child :Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  height: size.height * 0.2 - 27,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Bienvenid@!",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Spacer(),
                      //Image.asset("assets/iconos/001.PNG"),
                    ],
                  ),
                ),
                /*Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 54,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0,10),
                            blurRadius: 50,
                            color: Colors.deepPurple.withOpacity(1),
                          ),
                        ]
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Buscar...",
                        hintStyle: TextStyle(
                          color: Colors.deepPurple,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Image.asset("assets/iconos/001.png", color: Colors.deepPurple, scale: 50,),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
          Container(
              height: 50,
              margin: EdgeInsets.only(
                top: 20,
              ),
              child: Stack(
                children: [
                  Text("Categorias",
                    style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              )
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  categoria(imagen: "assets/imagenes/001.png", texto: "TIENDAS", controla: "tienda"),
                  categoria(imagen: "assets/imagenes/003.png", texto: "LAVANDERIA",controla: "lavanderia"),
                ],
              ),
              Row(
                children: [
                  categoria(imagen: "assets/imagenes/004.png", texto: "PIZZERIA",controla: "pizzeria"),
                  categoria(imagen: "assets/imagenes/005.png", texto: "CIGARRERIA",controla: "cigarreria"),
                ],
              ),
              Row(
                children: [
                  categoria(imagen: "assets/imagenes/006.png", texto: "FERRETERIA",controla: "ferreteria"),
                  categoria(imagen: "assets/imagenes/007.png", texto: "COMIDAS",controla: "comida"),
                ],
              ),
              Row(
                children: [
                  categoria(imagen: "assets/imagenes/008.png", texto: "PELUQUERIA",controla: "peluqueria"),
                  categoria(imagen: "assets/imagenes/009.png", texto: "PAPELERIA",controla: "papeleria"),
                ],
              ),

            ],

          ),

        ],

      ),


    );




  }
}

class categoria extends StatelessWidget {
  const categoria({
    Key? key,
    required this.imagen,
    required this.texto,
    required this.controla,

  }) : super(key: key);

  final String imagen, texto;
  final String controla;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      height: size.height * 0.3,
      margin: EdgeInsets.all(13),
      padding: EdgeInsets.all(1),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> negocios(controla)));
        },
        child: Column(
          children: <Widget>[
            ClipRect(
              child: Container(
                height: size.height * 0.2,
                child: FadeInImage(
                  placeholder: AssetImage(imagen),
                  image: AssetImage(imagen),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Image.asset(imagen, scale: 1),

            Container(
              padding: EdgeInsets.only(
                left: 30,
                bottom: 10,
                top: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 10,
                    color: Colors.deepPurple.withOpacity(1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  RichText(text: TextSpan(
                      text: "$texto",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)
                  ),
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

