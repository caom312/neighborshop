import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neighborshop/menulateral/menuLateral.dart';
import 'package:neighborshop/pantallas/negociomodelodata.dart';
import 'package:url_launcher/url_launcher.dart';
import 'listarnegocios.dart';


class descripcionnegocio extends StatefulWidget {
  final negociomodelodata Negociomodelodata;


  const descripcionnegocio({required this.Negociomodelodata});

  @override
  State<descripcionnegocio> createState() => _descripcionnegocioState();
}

class _descripcionnegocioState extends State<descripcionnegocio> {
  List geo = [];

  void initState() {
    super.initState();
    getGeo();
  }

  void getGeo() async{
    CollectionReference dato = FirebaseFirestore.instance.collection("Negocios");
    QuerySnapshot negocio = await dato.where("nombre", isEqualTo: widget.Negociomodelodata.nombre).get();
    if (negocio.docs.length !=0){
      for(var neg in negocio.docs){
        setState(() {
          geo.add(neg);
        });
        print(neg.data());
      }
    }else{
      print("no hay dato");

    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Set<Marker> marca = Set();
    for(var i in geo){
      late GeoPoint pos = geo[0]["geolocalizacion"];
        marca.add(Marker(
        markerId: MarkerId("a"),
        position: LatLng(pos.latitude,pos.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: InfoWindow(
            title: geo[0]["nombre"],
            snippet: geo[0]["telefono_fijo"]
          ),
    ),
    );
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.Negociomodelodata.nombre),
      ),
      drawer: drawermenulateral(context),

      body:ListView.builder(
        itemCount: geo.length,
        itemBuilder: (BuildContext context, i){
          return Column(
            children: [
              Container(
                height: size.height * 0.5,
                width: size.width * 0.9,
                child:GoogleMap(
                  initialCameraPosition: CameraPosition(target: LatLng(geo[i]["geolocalizacion"].latitude,geo[i]["geolocalizacion"].longitude),
                    zoom: 15,
                ),
                  markers: marca,
              ),
              ),
              miCardImage(url: widget.Negociomodelodata.foto, texto: widget.Negociomodelodata.nombre+"\n"+widget.Negociomodelodata.categoria
                  +"\nCel: "+widget.Negociomodelodata.celular+"\nDir:"+widget.Negociomodelodata.direccion+"\nTel: "+widget.Negociomodelodata.telefono_fijo),
              ElevatedButton(

                  onPressed: (){

                    launch(widget.Negociomodelodata.paginaweb.toString());
                  },
                  child: Text("Mi pagina web"))
            ],
          );
        }
      ),
    );
  }
}


