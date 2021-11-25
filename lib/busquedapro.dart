import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neighborshop/pantallas/descripcionnegocio.dart';
import 'package:neighborshop/pantallas/negociomodelodata.dart';


class busquedapro extends StatefulWidget {
  const busquedapro({Key? key}) : super(key: key);

  @override
  _busquedaproState createState() => _busquedaproState();
}

class _busquedaproState extends State<busquedapro> {

  TextEditingController producto=TextEditingController();
  List listaprod=[];
  List listaneg=[];
  List listaProductos=[];

  void initState(){
    super.initState();
    getProductos1();
  }


void getProductos1() async {
  CollectionReference productos = FirebaseFirestore.instance.collection('Productos');
  QuerySnapshot productos1 = await productos.get();
  if (productos1.docs.length!=0) {
    for (var prod1 in productos1.docs) {
      setState((){
        listaProductos.add(prod1.data());
      });

    }
  }
  else{
    print("Error...");
  }
}
  void getProductos() async {
    listaprod.clear(); //Elimina todos los datos que tenga el list
    listaneg.clear();

    CollectionReference productos = FirebaseFirestore.instance.collection(
        'Productos');
    QuerySnapshot productos1 = await productos.where(
        'nombre', isEqualTo: producto.text).get();
    if (productos1.docs.length != 0) {
      for (var prod in productos1.docs) {
        listaprod.add(prod.data());
      }
      for (var i = 0; i < listaprod.length; i++) {
        String id = listaprod[i]['negID'].toString();
        CollectionReference negocios = FirebaseFirestore.instance.collection(
            'Negocios');
        QuerySnapshot negocios1 = await negocios.where(
            FieldPath.documentId, isEqualTo: id).get();
        if (negocios1.docs.length != 0) {
          for (var nego in negocios1.docs) {
            setState(() {
              listaneg.add(nego.data());
            });
          }
        }
        else {
          print("Error");
        }
      }
    }
    else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("NeighborShop"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: size.height * 0.2,
              child: Stack(
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
                          "Producto",
                          style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                        Spacer(),
                        //Image.asset("assets/iconos/001.PNG"),
                      ], //children
                    ),
                  ),
                  Positioned(
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
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Colors.deepPurple.withOpacity(1),
                            ),
                          ]
                      ),
                      child: TextField(

                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: "Digite el nombre del producto",
                            hintStyle: TextStyle(
                              color: Colors.deepPurple,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,

                            icon: Image.asset(
                              "assets/iconos/001.png", color: Colors.deepPurple,
                              scale: 50,),
                          ),
                          controller: producto,
                          onSubmitted: (value) {
                            print("hola");
                            getProductos();
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Column(
              children: [
                (() {
                  if (listaneg.length != 0) {
                    return Column(
                        children: [
                          Container(
                              height: 50,
                              margin: EdgeInsets.only(
                                top: 20,
                              ),
                              child: Stack(
                                children: [
                                  Text("Negocios",
                                    style: TextStyle(color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                ],
                              )
                          ),
                         Column(
                            children: [
                              for(var i = 0; i < listaneg.length; i++)(
                                  ListTile(
                                    onTap: () {
                                      print(listaneg[i]);
                                      negociomodelodata n = negociomodelodata(
                                          listaneg[i]['categoria'],
                                          listaneg[i]['celular'],
                                          listaneg[i]['direccion'],
                                          listaneg[i]['foto'],
                                          listaneg[i]['logo'],
                                          listaneg[i]['nombre'],
                                          listaneg[i]['paginaweb'],
                                          listaneg[i]['telefono_fijo']);
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              descripcionnegocio(
                                                  Negociomodelodata: n)));
                                    },
                                    title: Text(
                                        listaneg[i]['nombre'].toString()),
                                    subtitle: Text(
                                        listaneg[i]['categoria'].toString()),

                                    trailing: Icon(Icons.arrow_forward_ios),
                                    leading: SizedBox(
                                      width: 70,
                                      height: 70,
                                      child: Image.network(listaneg[i]['logo']),
                                    ),

                                    //title: miCardImage(url: datos_negocios[j]['foto'],texto: datos_negocios[j]['nombre']+" "+datos_negocios[j]['categoria']+'\n'+datos_negocios[j]['celular'])
                                  )
                              ),
                            ],
                          ),
                        ] //children
                    );
                  }
                  else {
                    return Column(
                        children: [
                          Container(
                              height: 50,
                              margin: EdgeInsets.only(
                                top: 20,
                              ),
                              child: Stack(
                                children: [
                                  Text("Productos",
                                    style: TextStyle(color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                ],
                              )
                          ),
                          Column(
                            children: [
                              for(var a = 0; a<listaProductos.length; a++)(
                                  ListTile(

                                    title: Text(
                                        listaProductos[a]['nombre'].toString()),
                                    subtitle: Text("Precio: " +
                                        listaProductos[a]['precio'].toString()),

                                    trailing: Icon(Icons.arrow_forward_ios),

                                  )
                              ),
                            ],
                          ),
                        ] //children
                    );
                  }
                }()) //Codigo DART
              ], //Children
            ),

          ], //children
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
