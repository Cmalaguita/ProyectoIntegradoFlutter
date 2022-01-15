import 'package:ejerciciocomponentes/src/pages/login_page.dart';
import 'package:ejerciciocomponentes/src/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/pages/alert_page.dart';
import 'src/pages/avatar_page.dart';
import 'src/pages/offers_page.dart';
import 'src/pages/home_page.dart';
import 'src/pages/login_page.dart';
Future <void> main() async {
  //Metodo que carga la libreria de variables de entorno.
  await dotenv.load(fileName: 'environment.env');
  dotenv.isEveryDefined(['ID_CICLO']);
  dotenv.isEveryDefined(['ID_ALUMNO']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
   Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,
      title: 'Doors n Corners',
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
      'card': (context) => OffersPage(),
      'avatar': (context) => AvatarPage()
    };
  }


