import 'package:ejerciciocomponentes/navigation_drawer/navigation_drawer.dart';
import 'package:ejerciciocomponentes/src/pages/card_page.dart';
import 'package:ejerciciocomponentes/src/utils/icon_utils.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../menu_provider.dart';
import 'alert_page.dart';

class MyHomePage extends StatelessWidget {
  final List<String> opciones = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinque'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body:Center(
child: Column(

mainAxisAlignment: MainAxisAlignment.start,
children: <Widget>[
Text('Inicio',style: TextStyle(color: Colors.redAccent,fontFamily: 'Leelawadee',fontWeight:FontWeight.bold,fontSize:55),


),



],

),

      ) ,
     drawer: navigationDrawer(),   
    );
  }

}
