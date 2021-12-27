import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neighborshop/buscadorappbar/SearchNegociosDelegate.dart';
import 'package:neighborshop/menulateral/menuLateral.dart';
import 'package:neighborshop/pantallas/descripcionnegocio.dart';



class listarnegocios extends StatefulWidget {
  const listarnegocios({Key? key}) : super(key: key);

  @override
  _listarnegociosState createState() => _listarnegociosState();
}

class _listarnegociosState extends State<listarnegocios> {
    List datos_negocios =[];

  void initState(){
    super.initState();
    getNegocios();
  }

  void getNegocios() async {
    //utilizamos las dependencias, Conectar la coleccion
    CollectionReference datos= FirebaseFirestore.instance.collection("Negocios");
    //consultamos y traemos todas las personas, igual select * from tabla
    QuerySnapshot negocios= await datos.get();

    if(negocios.docs.length>0){
      print("Trae Datos");

      for(var doc in negocios.docs){
        print(doc.data());
        setState(() {
          datos_negocios.add(doc.data());

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

        title:  ListTile(
          onTap: (){
            final List<negociomodelodata2> negociodatos = List.generate(
                datos_negocios.length, (index) => negociomodelodata2(datos_negocios[index]['categoria'],
                datos_negocios[index]['celular'],datos_negocios[index]['direccion'],
                datos_negocios[index]['foto'],datos_negocios[index]['logo'],datos_negocios[index]['nombre'],
                datos_negocios[index]['paginaweb'],datos_negocios[index]['telefono_fijo'],datos_negocios[index]['geolocalizacion']));
            showSearch(
              context: context,
              delegate: SearchNegociosDelegate(negociodatos),
            );
          },

          title: const Text(
              'Clic para Buscar Negocio \u{1F50D}',  textAlign: TextAlign.left, style: TextStyle(color: Colors.white,fontSize: 14)),

      ),
      ),
      drawer: drawermenulateral(context),
      body: ListView.builder(
          itemCount: datos_negocios.length,
          itemBuilder: (BuildContext context,j){
            return ListTile(
                onTap:(){
                  print(datos_negocios[j]);


                  negociomodelodata2 n = negociomodelodata2(datos_negocios[j]['categoria'],datos_negocios[j]['celular'],
                      datos_negocios[j]['direccion'],datos_negocios[j]['foto'],
                      datos_negocios[j]['logo'],datos_negocios[j]['nombre'],datos_negocios[j]['paginaweb'],
                      datos_negocios[j]['telefono_fijo'],datos_negocios[j]['geolocalizacion']);
                      print(n);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>descripcionnegocio(Negociomodelodata: n)));



                },
              title: Text(datos_negocios[j]['nombre'].toString()),
              subtitle:Text(datos_negocios[j]['categoria'].toString()),
              /*leading:CircleAvatar(
                child:Text(datos_negocios[j]['nombre'].substring(0,1)),
              ),*/
              trailing: Icon(Icons.arrow_forward_ios),
              leading:SizedBox(
                width: 70,
                height: 70,
                child: Image.network(datos_negocios[j]['logo']),
              ),

                //title: miCardImage(url: datos_negocios[j]['foto'],texto: datos_negocios[j]['nombre']+" "+datos_negocios[j]['categoria']+'\n'+datos_negocios[j]['celular'])
            );
          }),
    );
  }

}


//crear widget de tarjetas, que va a manejar informacion de la consulta
class miCardImage extends StatelessWidget {
  final String url;
  final String texto;

  const miCardImage({required this.url, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        margin: EdgeInsets.all(20),
        elevation: 10,
        color: Colors.deepPurple,
        //permite poner el contenido de la tarjeta
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Column(
              children: [
                Image.network(url),
                Container(
                    padding:  EdgeInsets.all(10),
                    color: Colors.deepPurple,
                    child: Text(texto,style: TextStyle(fontSize: 20, color: Colors.white),textAlign: TextAlign.center)

                )
              ]
          ),
        )
    );
  }
}

class negociomodelodata2 {

  String categoria="";
  String celular="";
  String direccion="";
  String foto="";
  String logo="";
  String nombre="";
  String paginaweb="";
  String telefono_fijo="";
  late GeoPoint geolocalizacion;


  negociomodelodata2(
      this.categoria,
      this.celular,
      this.direccion,
      this.foto,
      this.logo,
      this.nombre,
      this.paginaweb,
      this.telefono_fijo,
      this.geolocalizacion);


}




