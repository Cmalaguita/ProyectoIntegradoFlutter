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
        title: const Text('Ejercicio de menús'),
      ),
      body: _lista(),

      
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
        ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

       // This trailing comma makes auto-formatting nicer for build methods.

  Widget _lista() {
    return FutureBuilder(
        future: menuProvider.cargarData(),
        initialData: [],
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return ListView(
            children: _listaItems(snapshot.data, context),
          );
        });
  }

  List<Widget> _listaItems(List<dynamic>? data, BuildContext context) {
    final List<Widget> opciones = [];
    data?.forEach((item) {
      final tempWidget = ListTile(
        title: Text(item['texto']),
        leading: getIcon(item['icon']),
        trailing: const Icon(Icons.arrow_right),
        onTap: () {
          Navigator.pushNamed(context, item["ruta"]);
        },
      );
      opciones.add(tempWidget);
      opciones.add(Divider());
    });
    return opciones;
  }

  List<Widget> _crearItemsCorto(context) {
    return opciones.map((opcion) {
      return Column(
        children: [
          ListTile(
            title: Text(opcion),
            subtitle: Text('hola tete'),
            leading: Icon(Icons.account_box_rounded),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              final ruta = MaterialPageRoute(builder: (context) => AlertPage());
              Navigator.push(context, ruta);
            },
          ),
          Divider()
        ],
      );
    }).toList();
  }
}
