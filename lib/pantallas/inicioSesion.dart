import 'package:flutter/material.dart';
import 'package:neighborshop/menulateral/menuLateral.dart';

class inicioSesion extends StatefulWidget {
  const inicioSesion({Key? key}) : super(key: key);

  @override

  _inicioSesionState  createState() => _inicioSesionState();
}



class _inicioSesionState extends State<inicioSesion> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text("Iniciar Sesion"),
        ),
        //drawer:  drawermenulateral(context),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (texto){
                  setState(() {

                  });

                },
                autofocus: false,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    labelText: 'usuario',
                    prefixIcon: Icon(Icons.account_box_outlined, color: Colors.deepPurple),
                    hintText: "Ingrese su Usuario"
                ),

              ),

            ),

            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (texto){
                  setState(() {

                  });

                },

                autofocus: false,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    labelText: 'password',
                    prefixIcon: Icon(Icons.security, color: Colors.deepPurple),
                    hintText: "Ingrese su Password"


                ),

              ),
            ),

            ElevatedButton(


                onPressed: (){

                    Center(
                      child: Text("Datos Errados",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.blue),),
                    );

                },

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text("Iniciar Sesion")

                  ],
                )
            ),


            /*Center(
              child: Text("Hola "+txt,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.blue),),
            )*/
          ],
        )

    );
  }


}





