import 'package:ejerciciocomponentes/src/menu_provider.dart';
import 'package:ejerciciocomponentes/src/pages/alert_page.dart';
import 'package:ejerciciocomponentes/src/utils/icon_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class navigationDrawer extends StatelessWidget {
  final List<String> opciones = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinque'];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        // child:_lista(),
        
        
        child: ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text('Bahamadia'),
          accountEmail: Text('Bahamadia.og@gmail.com'),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                'https://learn.zoner.com/wp-content/uploads/2015/06/028mm.jpg?fidl=2019-06-mag-en',
                fit: BoxFit.cover,
                width: 70,
                height: 80,
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.blue.shade500,
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://static.vecteezy.com/system/resources/previews/001/217/366/non_2x/polygonal-blue-background-vector.jpg'),
              )),
            
        ),
Container(

child: const Text('Polla'),

)
      ],
    )
    
    );
  }

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
