import 'package:flutter/material.dart';
import 'package:neighborshop/menulateral/menuLateral.dart';
import 'package:neighborshop/pantallas/negociomodelodata.dart';
import 'package:url_launcher/url_launcher.dart';
import 'listarnegocios.dart';


class descripcionnegocio extends StatelessWidget {
  final negociomodelodata Negociomodelodata;

  const descripcionnegocio({required this.Negociomodelodata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Negociomodelodata.nombre),
      ),
      drawer: drawermenulateral(context),

      body:ListView(
        children: [
          miCardImage(url: Negociomodelodata.foto, texto: Negociomodelodata.nombre+"\n"+Negociomodelodata.categoria
              +"\nCel: "+Negociomodelodata.celular+"\nDir:"+Negociomodelodata.direccion+"\nTel: "+Negociomodelodata.telefono_fijo),
          ElevatedButton(

              onPressed: (){

                launch(Negociomodelodata.paginaweb.toString());
              },
              child: Text("Mi pagina web"))
        ],
      ),


    );
  }
}


