
import 'package:flutter/material.dart';
import 'package:neighborshop/pantallas/descripcionnegocio.dart';
import 'package:neighborshop/pantallas/listarnegocios.dart';
import 'package:neighborshop/pantallas/negociomodelodata.dart';

class SearchNegociosDelegate extends SearchDelegate<negociomodelodata>{
 final List<negociomodelodata2> negocios;
 SearchNegociosDelegate(this.negocios);

 List<negociomodelodata2> _filter=[];

  //crear boton limpiar del buscador
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query='';
      },
        icon: const Icon(Icons.close),
      ),
    ];

  }

  //boton regresar a la pantalla anterior, igual al navegator.pop
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context,negociomodelodata('','','','','','','',''));
          _filter.clear();
        },
        icon: const Icon(Icons.arrow_back)
    );


  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = negocios.where((negociomodelodata2){
      return negociomodelodata2.nombre.toLowerCase().contains(query.trim().toLowerCase());

    }).toList();
    return ListView.builder(
        itemCount: _filter.length,
        itemBuilder: (BuildContext context,j){
          return ListTile(
            onTap:(){
              print(_filter[j]);
              negociomodelodata2 n = negociomodelodata2(_filter[j].categoria,_filter[j].celular,
                  _filter[j].direccion,_filter[j].foto,_filter[j].logo,
                  _filter[j].nombre,_filter[j].paginaweb,
                  _filter[j].telefono_fijo,_filter[j].geolocalizacion);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>descripcionnegocio(Negociomodelodata: n)));


            },
            title: Text(_filter[j].nombre),
            subtitle:Text(_filter[j].categoria),
            /*leading:CircleAvatar(
                child:Text(datos_negocios[j]['nombre'].substring(0,1)),
              ),*/
            trailing: Icon(Icons.arrow_forward_ios),
            leading:SizedBox(
              width: 70,
              height: 70,
              child: Image.network(_filter[j].logo),
            ),

            //title: miCardImage(url: datos_negocios[j]['foto'],texto: datos_negocios[j]['nombre']+" "+datos_negocios[j]['categoria']+'\n'+datos_negocios[j]['celular'])
          );
        });
  }

}