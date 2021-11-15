import 'package:ejerciciocomponentes/src/pages/login_page.dart';
import 'package:ejerciciocomponentes/src/pages/signup_page.dart';
import 'package:flutter/material.dart';

import 'src/pages/alert_page.dart';
import 'src/pages/avatar_page.dart';
import 'src/pages/card_page.dart';
import 'src/pages/home_page.dart';
import 'src/pages/login_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
   Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,
      title: 'Sockets Students',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(),
      initialRoute: 'login',
      routes: _crearRutas(context),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => MyHomePage());
      },
    );
  }
}

Map<String, WidgetBuilder> _crearRutas(context) {
    return <String, WidgetBuilder>{
      'signup':(context)=>SignUpPage(),
      'login':(context)=>LoginPage(),
      '/': (context) => MyHomePage(),
      AlertPage.pageName: (context) => AlertPage(),
      'card': (context) => CardPage(),
      'avatar': (context) => AvatarPage()
    };
  }


