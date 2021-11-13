import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neighborshop/consultanegocios.dart';


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
      title: ' Firebase de Cristiann',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Firebase hecho en clase Clase...'),
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
  List datos_personas=[];
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
          datos_personas.add(doc.data());


        });

      }
    }else{
      print("Ha fallado.......");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: const Text("Listado de Negocios"),
      ),
      body: Center(
        child: ListView.builder(
          //longitud items a generar
          itemCount: datos_personas.length,
          itemBuilder: (BuildContext context,i){
            return ListTile(
              title: Text("Negocio "+i.toString()+" - "+datos_personas[i]['nombre'].toString()),


            ) ;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> consultanegocios()));
        },
        label: Text("Sigiente"),
        icon: Icon(Icons.arrow_forward),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


