import 'package:ejerciciocomponentes/navigation_drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card'),
      ),
       body:Center(
child: Column(

mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
Text('Tarjetas',style: TextStyle(color: Colors.redAccent,fontFamily: 'Leelawadee',fontWeight:FontWeight.bold,fontSize:55),)



],

),

      ) ,
     drawer: navigationDrawer(),
    );
  }
}
