import 'package:ejerciciocomponentes/navigation_drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  static final pageName = 'alert';

  @override
  _alertPageState createState() => _alertPageState();
}

class _alertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Alertas'),
      ),
       body:Center(
child: Column(

mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
Text('Proximamente',style: TextStyle(color: Colors.redAccent,fontFamily: 'Leelawadee',fontWeight:FontWeight.bold,fontSize:55),)



],

),

      ) ,
     drawer: navigationDrawer(),
    );
  }
}
