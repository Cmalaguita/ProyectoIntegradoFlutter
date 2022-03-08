import 'package:ejerciciocomponentes/src/menu_provider.dart';
import 'package:ejerciciocomponentes/src/utils/icon_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///esta clase contiene un drawer que recibe una lista de paginas provenientes de un json desde las que el usuario puede acceder al resto de paginas de la aplicacion, salvo al login y al registro.
class navigationDrawer extends StatelessWidget {
  final List<String> opciones = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinque'];

  @override
  Widget build(BuildContext context) {
    return Drawer(
       
        child:_lista(),
    );
  }
/// metodo que devuelve un futurebuilder con una listview que contiene las direcciones de paginas desde las que el usuario accederá al drawer
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
  /// metodo que retorna una lista de listTiles que obtiene a traves del menuprovider del metodo _lista
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
}
