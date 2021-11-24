import 'package:flutter/material.dart';

class descripcionPro extends StatefulWidget {
  final String con;
  const descripcionPro( this.con, {Key? key}) : super(key: key);

  @override
  _descripcionProState createState() => _descripcionProState();
}

class _descripcionProState extends State<descripcionPro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),body: Column(
        children: [
          Text(widget.con, style: TextStyle(fontSize: 20,),),
        ],
    ),
    );
  }
}
